class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    case resource.class.name.underscore.to_sym
    when :admin
      admin_root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    # @stylesheet_direction = I18n.locale == :ar ? 'rtl' : 'ltr'
  end
end