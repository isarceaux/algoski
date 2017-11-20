module ApplicationHelper
  def list_station
    # #take all ville in an array
    villes = Classified.group("ville").order("ville").pluck("ville")
    # #iterate over the array
    list_of_station = []
    # regions = ['66612889','66612807','66612786','66612960','66612917','66612918','66612972','66612919','66612803','66612962'] #Les trois vallées + Tignes et Val d'Isère

    # villes.each do |i|
    #   if i
    #     if Resort.find_by_ville(I18n.transliterate(i))
    #        if Classified.where("ville":"#{i}").count > 10 && (regions.include? Resort.find_by_ville(I18n.transliterate(i)).region_number)
    #          list_of_station.push(titleize(i))
    #       end
    #     end
    #   end
    # end

    villes.each do |i|
      if i
        if Resort.find_by_ville(I18n.transliterate(i))
           if Classified.where("ville = ?",i).count > 100 
             list_of_station.push(titleize(i))
          end
        end
      end
    end

    # Resort.where(ski_resort:true).group('ville').pluck('ville').each do |r|
    #   list_of_station << titleize(r)
    # end

    list_of_station.sort
    return(list_of_station)

  end

  def titleize(title)
    new_title = ""
    if title != nil
      title.split.each do |word|
        if new_title == ""
          new_title << word.capitalize
        elsif ["les", "le", "de"].include? word
          new_title << " "
          new_title << word
        elsif ["d'isere"].include? word
          new_title << " "
          new_title << "d'Isere"
        else  
          new_title << " "
          new_title << word.capitalize
        end
      end
    end

    return new_title
  end


end


