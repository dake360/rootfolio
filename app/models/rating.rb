class Rating
  include Mongoid::Document
  include Mongoid::Timestamps
  VALID_RATINGS = (1..5).collect

  embedded_in :intrigue_item, :inverse_of => :ratings

  field :score, :type => Integer
  field :review

  referenced_in :user
  validates :score, :presence => true, :inclusion => { :in => VALID_RATINGS }
end
