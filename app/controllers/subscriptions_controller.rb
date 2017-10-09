class SubscriptionsController < ApplicationController
 
  def destroy
    Subscription.find(params[:id]).destroy
    redirect_to dashboards_profile_path
  end

end
