class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :set_locale
   before_action :configure_permitted_parameters, if: :devise_controller?
	#before_action :authenticate_user!
  layout :layout_by_resource

  protected  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:first_name, :last_name, :password, :password_confirmation, :email, :current_password)
    end
  end

	private

	def set_locale
	I18n.locale = params[:locale] || I18n.default_locale
	end

  def layout_by_resource
    if devise_controller?
      # 'devise'
      'application_dashboard'
    # elsif dashboards_controller?
    #   'application_dashboard'
    # else
    #   'application'
    end
  end

 

  #   def after_sign_in_path_for(resource)
  #     sign_in_url = new_user_session_url
  #     if request.referer == sign_in_url
  #       super
  #     else
  #       stored_location_for(resource) || request.referer || root_path
  #     end
  #   end

end
