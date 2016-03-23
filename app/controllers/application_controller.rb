class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for :sign_up do |u|
      u.permit :name, :email, :chatwork_id,
        :password, :password_confirmation
    end
    devise_parameter_sanitizer.for :account_update do |u|
      u.permit :name, :email, :chatwork_id, :password, :password_confirmation,
        :current_password
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
