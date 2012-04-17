class MetaData
  include Mongoid::Document
  include Mongoid::Timestamps

  DATA_TYPES = %w(boolean)


  field :name
  field :data_type

  references_many :intrigue_items, :stored_as => :array, :inverse_of => :meta_data

  validates :name, :presence => true
  validates :data_type, :presence => true, :inclusion => { :in => DATA_TYPES, :allow_blank => true }

  # TODO: remove when updating to Mongoid 2.0 final
  def intrigue_items
    IntrigueItem.any_in(:meta_datum_ids => [self.id])
  end
end
