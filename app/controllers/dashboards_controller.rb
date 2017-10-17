class DashboardsController < ApplicationController

  layout 'application_dashboard'
  include DashboardsHelper
  
  def analysis
    @action_tag = 'analysis'
    
    @demo = true 
    if user_signed_in? && current_user.subscriptions[0] != nil
      @demo = false
    end

    current_resort = current_resort_calculation

    @number_of_guests = 4 # To be changed with params and current_user data
    
    if params[:number_of_guests]
      @number_of_guests = params[:number_of_guests]
    end 

    if params[:current_resort] != "" && params[:current_resort]
      current_resort = Resort.find_by( ville:params[:current_resort] )
    end 
    
    @station_name = current_resort.ville

    # Average calculation

    @classifieds_count_local = Classified.where(resort:current_resort).count
    @classifieds_count_global = Classified.all.count
    @housings_count_local = Classified.where(resort:current_resort).group('link').pluck('link').count
    @housings_count_global = Classified.group('link').pluck('link').count 
    
    gon.averages = Average.where(resort:current_resort).where(number_of_guests:@number_of_guests)

    # Analysis on housings
    selected_housings = Housing.where(resort:current_resort).where(number_of_guests:@number_of_guests)
    total_count = selected_housings.count.to_f
    
    gon.property_type = []
    selected_housings.group('property_type').count.each do |s|
      hash_each = {}
      hash_each['label'] = s[0]
      hash_each['value'] = (s[1]/total_count)
      puts hash_each
      gon.property_type << hash_each
    end

    @average_number_of_bedrooms = (selected_housings.sum('number_of_bedrooms') / total_count).round(1)
    @average_number_of_bathrooms = ( (selected_housings.sum('number_of_bathrooms_full') + (selected_housings.sum('number_of_bathrooms_half') ) ) / total_count).round(1)

    gon.comment_data = []
    hash_no_comment = {}
    hash_comment = {}
    hash_no_comment['label'] = 'Aucun commentaire'
    no_comments = selected_housings.where(review_count:0).count/total_count
    hash_no_comment['value'] = no_comments
    gon.comment_data << hash_no_comment
    hash_comment['label'] = '1 commentaire ou +'
    hash_comment['value'] = 1 - no_comments
    gon.comment_data << hash_comment
    puts gon.comment_data

    @average_rating = selected_housings.where.not(review_count:0).average('average_rating').round(1)
    @average_number_of_comments = selected_housings.where.not(review_count:0).average('review_count').round()

    @rate_of_instant_booking = ( selected_housings.where(instant_bookable:true).count / total_count * 100 ).round()
    @rate_of_7_nights = ( selected_housings.where(min_stay_range_low:7).count / total_count * 100 ).round()
    @rate_of_payable_online = ( selected_housings.where(accepts_home_away_payments:true).count / total_count * 100 ).round()
    @rate_of_payable_offline = ( selected_housings.where(online_bookable:true).count / total_count * 100 ).round()

  end

  def data_table
    @action_tag = 'data_table'
    
    # Initialization
    classifieds_hash = {}

    current_resort = current_resort_calculation

    if params[:current_resort] != "" && params[:current_resort]
      current_resort = Resort.find_by( ville:params[:current_resort] )
    end 
    
    @station_name = current_resort.ville

    #Determining the classifieds to be displayed
    classifieds_hash[current_resort.ville] = Classified. where(resort_id:current_resort.id)
    @selected_classifieds = classifieds_hash[current_resort.ville]

  end


  def profile
    @user = current_user

    #Inscription
    s = Subscription.new
    s.user = current_user
    if params["ville"]
      s.resort = Resort.find_by_ville(params["ville"].downcase)
    end

    if s.resort
      @current_ville_id = s.resort.id
    end

    if Subscription.where(user_id:current_user.id).where(resort_id:@current_ville_id) == []
      s.save
    else
      flash.now[:alert] = "Vous êtes déjà abonné(e) à cette station!"  
    end

    @subscriptions = Subscription.where(user_id:current_user.id)

  end

  def map
    
  end

end
