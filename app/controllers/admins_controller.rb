class AdminsController < ApplicationController
  before_filter :find_model

  def index
  end

  private
  def find_model
    @admin = current_admin if admin_signed_in?
  end
end