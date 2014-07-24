class AdminsController < ApplicationController
  before_filter :find_model
  before_filter :authenticate_admin!

  def show
  end

  private
  def find_model
    @admin = current_admin if admin_signed_in?
  end
end