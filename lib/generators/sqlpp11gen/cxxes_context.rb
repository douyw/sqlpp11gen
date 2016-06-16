require_relative 'cxxes_helper'

class CxxesContext
  include CxxesHelper

  attr_accessor :tablename, :tableklass, :cols
  def template_binding
    binding
  end

end

