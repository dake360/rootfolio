class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :intrigue_item, :inverse_of => :comments

  field :body
  referenced_in :user

  validates :body, :user, :presence => true
  validates_associated :user
end
