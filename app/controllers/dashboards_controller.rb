class DashboardsController < ApplicationController

  layout 'application_dashboard'
  
  def analysis
    @averageprice = 100
    gon.lowerprice = 50
    
    current_resort = Resort.find_by(ville:'tignes')
    current_number_of_guests = 4
    # To be changed with params and current_user data
    
    @station_name = current_resort.ville
    @number_of_guests = current_number_of_guests

    @classifieds_count_local = Classified.where(resort:current_resort).count
    @classifieds_count_global = Classified.all.count
    @housings_count_local = Classified.where(resort:current_resort).group('link').pluck('link').count
    @housings_count_global = Classified.group('link').pluck('link').count 
    
    gon.averages = Average.where(resort:current_resort).where(number_of_guests:current_number_of_guests)

  end

  def data_table

    # Initialization
    classifieds_hash = {}

    #Demo
    demo_resort = Resort.find_by(ville:'tignes')
    
    #Choosing current resort (can use params)
    current_resort = demo_resort

    @station_name = current_resort.ville

    #Determining the classifieds to be displayed
    classifieds_hash[current_resort.ville] = Classified. where(resort_id:current_resort.id)
    @selected_classifieds = classifieds_hash[current_resort.ville]

  end

  def profile
  end
end
