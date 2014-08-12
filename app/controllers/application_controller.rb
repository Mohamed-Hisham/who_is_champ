class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    case resource.class.name.underscore.to_sym
    when :admin
      admin_badges_path(current_admin)
    when :creator
      creator_path(current_creator)
    when :user
      user_path(current_user)
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :creator
      root_path
    when :user
      root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # remove the locale from url if the default is chosen already
  def default_url_options(options={})
    (I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ? {} : {locale: I18n.locale})
  end

  protected
  def authenticate_inviter!
    #should be true if creator is logged in, I would use your #creator_signed_in? method
    authenticate_creator!(:force => true)
  end
end