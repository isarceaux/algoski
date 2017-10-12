class PagesController < ApplicationController

  def home
    @resort_count = Resort.where(ski_resort:true).group('ville').pluck('ville').count
  end

  def contact
  end

  def legal
  end

end
