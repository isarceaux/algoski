class ScrappingWorker
  include Sidekiq::Worker

  attr_accessor :double,
                :region

  URL_FIX_FIRST   = 'https://www.abritel.fr/ajax/map/results/refined'
  URL_FIX_SECOND  = '/@,,,,z'
  SEASON_START    = Date.new(2017, 12, 9)
  SEASON_END      = Date.new(2018, 5, 5)

  def initialize
    self.double     = 0
  end

  def perform(region)
    Sidekiq.logger.info "*Scrapping for region #{region}*"

    self.region     = region

    (SEASON_START...SEASON_END).step(7).each do |date|
      Sidekiq.logger.info "--**--**--**--**--**--**--**--**Scrapping for starting date #{date}**--**--**--**--**--**--**--**--"

      page = 1

      loop do
        json = HTTParty.get(url(date, page)).parsed_response
        Sidekiq.logger.info url(date, page)
        Sidekiq.logger.info "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-Scrapping page #{page}-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
        get_data_from_json(date, json)

        # break if (page > 5 && page >= json['results']['pageCount'] ) || page >= 15
        if page > 2
          Sidekiq.logger.info "================================already visited 15 pages, so quit the loop================================"
          break
        elsif page >= json['results']['pageCount']
          Sidekiq.logger.info "================================page count from json seems lower so quit the loop================================"
          break
        else
          page += 1  
        end

      end
    end


    Sidekiq.logger.info "number of duplicates avoided: #{self.double}"
  end

  def get_data_from_json(date, results_json)

    search_results = results_json['results']['hits']

    search_results.each do |r|
      if r['averagePrice'] && r['headline'] && r['detailPageUrl']

        geography = r['regionPathHierarchy'].split(':')

        #-------------- Finding a resort or creating one --------------

        current_resort = Resort.find_by_ville(geography[3])
        current_resort_found = true

        if current_resort == nil
          if r["geography"]["ids"][1]
            Resort.create(region_number:r["geography"]["ids"][1]["value"],ville:geography[3],ville_url:URI.escape(geography[3]))
            Sidekiq.logger.info "-*-*-*-New Resort created-*-*-*-"
            current_resort = Resort.last
          else
            Sidekiq.logger.info "-*-*-*-Cannot record because can't link Classified with a Resort-*-*-*-"
            current_resort_found = false
          end
        end

        #-------------- End of finding a resort or creating one --------------

        #--------------  Classified creation --------------    

        if current_resort_found

          if Classified.find_by(link: r["detailPageUrl"], start_date: date)
            c = Classified.find_by(link: r["detailPageUrl"], start_date: date)
            Sidekiq.logger.info "------------------!!! Already in database - will be updated !!!------------------"
          else
            c = Classified.new
            Sidekiq.logger.info "------------------ New classified to be added to database ------------------"
          end

            c.start_date =             date
            c.end_date =               date + 7
            c.title =                  r["headline"]
            c.price =                  r["averagePrice"]["value"]
            c.link =                   r["detailPageUrl"]
            c.number_of_guests =       r["sleeps"].to_i
            c.abritel_id =             r["listingNumber"].to_i
            c.abritel_classified_id =  r["listingId"]
            c.country =                geography[0]
            c.region =                 geography[1]
            c.departement =            geography[2]
            c.ville =                  geography[3]
            c.quartier =               geography[4]

            c.resort = current_resort
            c.save

        end

        #--------------  End of classified creation --------------    

        #--------------  Housing creation --------------    
        if current_resort_found # We need a resort to record a housing

          if Housing.find_by(link:r["detailPageUrl"])
            h = Housing.find_by(link:r["detailPageUrl"])
          else
            h = Housing.new
          end

            # Same as in classifieds
            h.title =                  r["headline"]
            h.number_of_guests =       r["sleeps"].to_i
            h.link =                   r["detailPageUrl"]

            # Additional data
            h.accepts_home_away_payments =           r["acceptsHomeAwayPayments"]
            h.accepts_offline_payments =             r["acceptsOfflinePayments"]
            h.accepts_credit_cards =                 r["acceptsCreditCards"]
            h.integrated_property_manager =          r["integratedPropertyManager"]
            h.multi_unit_property =                  r["multiUnitProperty"]
            h.online_bookable =                      r["onlineBookable"]
            h.instant_bookable =                     r["instantBookable"]
            h.number_of_bedrooms =                   r["bedrooms"].to_i
            h.number_of_bathrooms_full =             r["bathrooms"]["full"].to_i
            h.number_of_bathrooms_half =             r["bathrooms"]["half"].to_i
            h.number_of_bathrooms_toilet_only =      r["bathrooms"]["toiletOnly"].to_i
            h.number_of_bathrooms_full_and_half =    r["bathrooms"]["full"].to_i + r["bathrooms"]["half"].to_i
            h.image_count =                          r["imageCount"]
            h.property_name =                        r["propertyName"]
            h.property_type =                        r["propertyType"]
            h.geocode_latitude =                     r["geoCode"]["latitude"].to_f
            h.geocode_longitude =                    r["geoCode"]["longitude"].to_f
            h.geocode_exact =                        r["geoCode"]["exact"]
            h.average_rating =                       r["averageRating"].to_f
            h.scaled_average_rating =                r["scaledAverageRating"].to_f
            h.review_count =                         r["reviewCount"].to_i
            
          if r["minStayRange"]
            if r["minStayRange"]["minStayLow"]
              h.min_stay_range_low  = r["minStayRange"]["minStayLow"].to_i
            end
            if r["minStayRange"]["minStayHigh"]
              h.min_stay_range_high = r["minStayRange"]["minStayHigh"].to_i
            end
          end

          h.resort = current_resort
          
          # Need to create relationship with classified
          c.housing = h
          c.save

          h.save
          
        end
        #--------------  End of Housing creation --------------    

    end
  end
  end


  private
  def url(date, page)
    "#{URL_FIX_FIRST}#{region_url_part}#{date_url_part(date)}#{URL_FIX_SECOND}#{page_url_part(page)}"
  end

  def region_url_part
    "/region:#{self.region}"
  end

  def date_url_part(date_begin)
    "/arrival:#{date_begin}/departure:#{date_begin + 7}"
  end

  def page_url_part(page)
    "/page:#{page}"
  end
end