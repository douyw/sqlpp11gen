require 'rails/generators'
require 'generators/sqlpp11gen/cxxes_context'
require 'erb'

#Dir[File.dirname(__FILE__) + '/sqlpp11gen/*.rb'].each {|file| require file }

module Sqlpp11gen
  module Generators
    class Sqlpp11genGenerator < Rails::Generators::NamedBase
#      source_root File.expand_path('../templates', __FILE__)

      desc "Some description of my generator here"
 
      # Commandline options can be defined here using Thor-like options:
#      class_option :my_opt, :type => :boolean, :default => false, :desc => "My Option"

      # I can later access that option using:
      # options[:my_opt]


      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end


      def create_helper_file

#        tablename = plural_name
        tableklass = table_name.to_s.constantize
        cols = tableklazz.columns

        ctx = ::CxxesContext.new
        ctx.tablename = table_name
        ctx.tableklass = tableklass
        ctx.cols = cols

#        puts "File.dirname(__FILE__) #{File.dirname(__FILE__)}"

        template = File.read(File.join(File.dirname(__FILE__), "templates", "index.h.erb"))

#    create_file "app/cxxes/#{file_name}.hpp", <<-FILE
#module #{class_name}Helper
#  attr_reader :#{plural_name}, :#{plural_name.singularize}
#end
#    FILE
        create_file "app/cxxes/#{file_name}.hpp", ERB.new(template).result(ctx.template_binding)

      end
    end
  end
end
