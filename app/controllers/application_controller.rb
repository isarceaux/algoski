class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception
	before_action :set_locale
	#before_action :authenticate_user!
  layout :layout_by_resource

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

  # protected  
  #   def after_sign_in_path_for(resource)
  #     sign_in_url = new_user_session_url
  #     if request.referer == sign_in_url
  #       super
  #     else
  #       stored_location_for(resource) || request.referer || root_path
  #     end
  #   end

end
