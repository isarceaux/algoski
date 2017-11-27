module ApplicationHelper
  def list_station
    
    # #take all ville in an array
    villes = Classified.group("ville").order("ville").pluck("ville")
    # #iterate over the array
    list_of_station = []
    villes.each do |ville|
      if ville
        if Resort.find_by_ville(I18n.transliterate(ville))
           if Classified.where("ville = ?",ville).count > 100 
             list_of_station.push(titleize(ville))
          end
        end
      end
    end

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


