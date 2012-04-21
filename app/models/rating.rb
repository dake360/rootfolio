class Rating
  include Mongoid::Document
  include Mongoid::Timestamps
  VALID_RATINGS = (1..5).collect

  embedded_in :intrigue_item, :inverse_of => :ratings

  field :score, :type => Integer
  field :review

  referenced_in :user
  validates :score, :presence => true, :inclusion => { :in => VALID_RATINGS }
  # TODO: another hack, thanks Durran. MUST WRITE PLUGIN.
  before_save :update_parent_score

  protected
  def update_parent_score
    self.intrigue_item.send(:update_score)
  end
end
