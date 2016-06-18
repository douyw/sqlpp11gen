require 'rails/generators'
require 'active_record'
require 'generators/sqlpp11gen/cxxes_context'
require 'erb'

module Sqlpp11gen
  module Generators
    class TabGenerator < Rails::Generators::NamedBase
#      source_root File.expand_path('../templates', __FILE__)

      # Commandline options can be defined here using Thor-like options:
      argument :output_path,         :type => :string, :required => false, :desc => "setup output path for the generated file. The default output path is 'app/cxxes'."
      argument :filename_prefix,     :type => :string, :required => false, :desc => "setup a filename prefix for the generated file. The default one is 'tab_'."
      argument :filename_ext,        :type => :string, :required => false, :desc => "setup a filename ext for the generated file. The default one is 'hpp'."

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      def create_cxx_header_file

        tableklass = table_name.to_s.singularize.camelize.constantize

        ctx = ::CxxesContext.new
        ctx.tablename = table_name
        ctx.tableklass = tableklass
        ctx.cols = tableklass.columns

        template = File.read(File.join(File.dirname(__FILE__), "templates", "index.h.erb"))

        path = output_path || 'app/cxxes'
        prefix = filename_prefix || 'tab_'
        ext = filename_ext || 'hpp'

        create_file "#{path}/#{prefix}#{file_name}.#{ext}", ERB.new(template).result(ctx.template_binding)

      end

      protected

      def initialize_views_variables
      end

      def columns
        retrieve_columns.reject {|c| excluded?(c.name) }.map do |c|
          new_attribute(c.name, c.type.to_s)
        end
      end

      def excluded_columns_names
        %w[_id _type id created_at updated_at]
      end

      def excluded_columns_pattern
        [
          /.*_checksum/,
          /.*_count/,
        ]
      end

      def excluded_columns
        options['excluded_columns']||[]
      end

      def excluded?(name)
        excluded_columns_names.include?(name) ||
        excluded_columns_pattern.any? {|p| name =~ p } ||
        excluded_columns.include?(name)
      end

      def retrieve_columns
        if defined?(ActiveRecord) == "constant" && ActiveRecord.class == Module 
          rescue_block ActiveRecord::StatementInvalid do
            @model_name.constantize.columns
          end
        else
          rescue_block do
            @model_name.constantize.fields.map {|c| c[1] }
          end
        end
      end

      def new_attribute(name, type)
        ::Rails::Generators::GeneratedAttribute.new(name, type)
      end

      def rescue_block(exception=Exception)
        yield if block_given?
      rescue exception => e
        say e.message, :red
        exit
      end

    end
  end
end
