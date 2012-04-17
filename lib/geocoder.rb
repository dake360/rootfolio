# Based off Google's geocoding service.
module Geocoder
  class << self
    def geocode_address(address)
      raise ArgumentError, 'address cannot be null' unless address.present?
      resp = Typhoeus::Request.get("http://maps.googleapis.com/maps/api/geocode/json",
                             :params => {
                                     :address => address,
                                     :region => 'US',
                                     :sensor => false })
      data = ActiveSupport::JSON.decode(resp.body)
      return nil unless data['status'] == 'OK'
      loc = data['results'].first['geometry']['location']
      [loc['lat'], loc['lng']]
    end
  end
end