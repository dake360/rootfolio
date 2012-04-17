class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  embeds_one :address

  accepts_nested_attributes_for :address
end
