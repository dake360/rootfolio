class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :is_admin, :type => Boolean, :default => false

  embeds_one :profile
  embeds_one :address

  accepts_nested_attributes_for :profile, :address

  validates :username, :presence => true, :uniqueness => true

  def has_rated_intrigue?(intrigue)
    rating_for_intrigue(intrigue).present?
  end

  def rating_for_intrigue(intrigue)
    intrigue.ratings.detect { |r| r.user == self }
  end
end
