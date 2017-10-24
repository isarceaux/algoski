class SidekiqLaunch

  attr_accessor :regions

  def initialize
    
    @regions = []
    villes = Classified.group("ville").order("ville").pluck("ville")

    villes.each do |i|
      if i
        if Resort.find_by_ville(I18n.transliterate(i))
           if Classified.where("ville":"#{i}").count > 100 
             @regions << Resort.find_by_ville(i).region_number
          end
        end
      end
    end
  
    # @regions = Resort.all.pluck(:region_number)
    # @regions = ['66612889','66612807','66612786','66612960','66612917','66612918','66612972','66612919','66612803','66612962'] #Les trois vallées + Tignes et Val d'Isère
    # @regions = ['66612889','66612807']
    
  end


  def scrapping
    @regions.each do |region|
      ScrappingWorker.perform_async(region)
    end
  end

  def calculation
    @regions.each do |region|
      CalculatingWorker.perform_async(region)
    end
  end

end