class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
	#before_action :authenticate_user!
  layout :layout_by_resource

  protected  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:civility, :first_name, :last_name, :password, :password_confirmation, :email, :current_password)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:civility, :first_name, :last_name, :password, :password_confirmation, :email, :current_password)
    end
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || dashboards_profile_path
  end

  def after_update_path_for(resource)
    dashboards_profile_path
  end

	private

	def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
	end

  def layout_by_resource
    if devise_controller?
      'application_dashboard'
    end
  end

end
