module DashboardsHelper

   def titleize(title)
    new_title = ""

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

    return new_title
  end

  def cp(path)
    'active' if current_page?(path)
  end
  
end
