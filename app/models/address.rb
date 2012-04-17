class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :street_address
  field :city
  field :state
  field :zipcode
  field :latitude, :type => Float
  field :longitude, :type => Float
  # The geo field is used internally for geospatial searches.
  # it's basically [latitude, longitude]
  field :geo, :type => Array

  embedded_in :business, :inverse_of => :address

  validates :latitude, :longitude, :format => { :with => /\d+/, :allow_blank => true }
  validates :zipcode, :format => /\d+/, :allow_blank => true

  before_save :store_geo

  def mappable?
    latitude.present? && longitude.present?
  end

  protected
  def store_geo
    self.geo = [latitude, longitude] if latitude_changed? || longitude_changed?
  end
end
