class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name
  field :last_name
  field :age
  field :gender
  field :bio

  embedded_in :user, :inverse_of => :profile

  validates :age, :format => /\d+/, :allow_blank => true
end