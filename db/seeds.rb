# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create :email => 'test@example.com', :username => 'test', :password => 'password', :password_confirmation => 'password'
User.create :email => 'admin@example.com', :username => 'admin', :password => 'password', :password_confirmation => 'password', :is_admin => true

# These are test businesses -- destroy when we're ready to go into production

food_desire = Business.new :name => 'Food Desire'
food_desire.address = Address.new :latitude => -34.397, :longitude => 150.644
food_desire.save
