class DashboardsController < ApplicationController

  layout 'application_dashboard'
  
  def analysis
    @averageprice = 100
    gon.lowerprice = 50
    
    current_resort = Resort.find(19)
    current_number_of_guests = 4
    # To be changed with params and current_user data

    @classifieds_count_local = Classified.where(resort:current_resort).count
    @classifieds_count_global = Classified.all.count
    @housings_count_local = Classified.where(resort:current_resort).group('link').pluck('link').count
    @housings_count_global = Classified.group('link').pluck('link').count 
    
    gon.averages = Average.where(resort:current_resort).where(number_of_guests:current_number_of_guests)

  end

  def data_table
  end

  def profile
  end
end
