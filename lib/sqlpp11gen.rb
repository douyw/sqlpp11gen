require 'rails'
require 'active_support/dependencies'
require "sqlpp11gen/version"


module Sqlpp11gen
#  autoload :Delegator,          'devise/delegator'

  require 'sqlpp11gen/engine' if defined?(Rails)

  # The parent controller all Devise controllers inherits from.
  # Defaults to ApplicationController. This should be set early
  # in the initialization process and should be set to a string.
  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.bin
    File.join root, 'bin'
  end

  def self.lib
    File.join root, 'lib'
  end
end
