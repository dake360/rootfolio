class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  references_many :intrigue_items
end
