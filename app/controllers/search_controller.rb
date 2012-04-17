class SearchController < ApplicationController
  def index
    if request.post?
      redirect_to search_path(:q => params[:q], :loc => params[:loc])
      return
    end
    keywords = KeywordExtractor.extract(params[:q] || '')
    criteria = IntrigueItem.any_in(:keywords => keywords)
    if params[:loc].present?
      # ... if searching by zipcode only, don't do any geocoding tricks.
      if params[:loc] =~ /^\d+$/
        criteria = criteria.where('address.zipcode' => params[:loc])
      elsif @latlng = Geocoder.geocode_address(params[:loc])
        lat, lng = @latlng
        # Sphereical Model ($centerSphere)
        # Miles (n) to radians (r): n / 3959 = r
        # Regular model ($center)
        # Miles (n) to radians (r) n / 69 = r
        max_distance = 100 / 69
        # Mongo driver (and MongoDB) need these to be in alphabetical order. Yes, it is stupid.
        #criteria = criteria.where('address.geo' => BSON::OrderedHash['$near', [lat, lng], '$maxDistance', max_distance])
        criteria = criteria.where('address.geo' => { '$within' => {'$center' => [[lat, lng], max_distance] } })
      end
    end
    @intrigue_items = criteria.collect
  end
end
