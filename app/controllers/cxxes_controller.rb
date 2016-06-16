class CxxesController < ApplicationController
  def index
    @tablename = params[:model]
    @tablename = 'User' if @tablename.nil?
    @tableklass = @tablename.to_s.constantize
    @cols = @tableklass.columns
  end
end
