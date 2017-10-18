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
      list << titleize(s.resort.ville)
    end
    return list.sort
  end

  def current_resort_calculation
    if user_signed_in?
      if current_user.subscriptions[0] != nil
        current_resort = current_user.subscriptions.first.resort
      else
        current_resort = Resort.find_by(ville:'tignes')
      end
    else
      current_resort = Resort.find_by(ville:'tignes')
    end

    return current_resort
  end
  
end
