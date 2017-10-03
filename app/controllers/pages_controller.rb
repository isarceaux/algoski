class PagesController < ApplicationController

  def home
    @resort_count = Resort.group('ville').pluck('ville').count
  end

  def contact
  end

  def legal
  end

end
