class PagesController < ApplicationController

  def home
    @classifieds = Classified.all
  end

  def landingpage
    @resort_count = Resort.group('ville').pluck('ville').count
  end

  def about
  end

  def contact
  end

  def legal
  end

  def pricing
  end


end
