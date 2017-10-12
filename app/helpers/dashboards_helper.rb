module DashboardsHelper

  def cp(path)
    'active' if current_page?(path)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def list_of_resorts
    list = []
    current_user.subscriptions.each do |s|
      list << s.resort.ville
    end
    return list
  end
  
end
