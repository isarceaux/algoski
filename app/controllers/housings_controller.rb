class HousingsController < ApplicationController

  layout 'application_dashboard'

  def index
    @housings = Housing.all
  end
end
