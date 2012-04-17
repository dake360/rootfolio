class IntrigueItem
  include Mongoid::Document
  include Mongoid::Timestamps
  INTRIGUE_TYPES = %w(person place product)

  field :name
  field :interest
  # Keywords is a simple array of words (no spaces)
  field :keywords, :type => Array
  embeds_one :address
  embeds_many :comments
  embeds_many :ratings
  referenced_in :category

  references_many :meta_data, :class_name => 'MetaData', :stored_as => :array, :inverse_of => :intrigue_item

  # This allows geospatial searches on the emebdded addresses document.
  index [[ 'address.geo', Mongo::GEO2D ]]


  accepts_nested_attributes_for :address, :comments, :ratings

  validates :name, :interest, :presence => true
  validates :interest, :inclusion => { :in => INTRIGUE_TYPES }
  validates_associated :address

  # TODO: goddamn it, Durran
  before_save :trigger_callbacks

  before_save :update_keywords

  def current_rating
    return 0 if ratings.count == 0
    ratings.inject(0) { |memo, rating| memo + rating.score } / ratings.count
  end

  def update_keywords
    self.keywords = []
    self.keywords += KeywordExtractor.extract(self.name)
    meta_data_names = self.meta_data.select { |m| m.data_type == 'boolean' }.collect(&:name)
    self.keywords += KeywordExtractor.extract(meta_data_names.join(' '))
    self.keywords += KeywordExtractor.extract(self.category.name) if self.category.present?
  end

  def update_keywords!
    save!
  end
  # Goddamn seriously? SERIOUSLY?
  def meta_datum_ids=(ids)
    super ids.reject(&:blank?)
  end
  # TODO: goddamn it, Durran.
  # Mongoid won't fire the callbacks if using accepts_nested_attributes_for
  protected
  def trigger_callbacks
    return if address.blank?
    address.run_callbacks(:save)
  end
end
