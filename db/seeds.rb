# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create( 
  :email                		=> 'chase.southard@cogitools.com', 
  :password   					=> 'r3g4pp!',
  :password_confirmation        => 'r3g4pp!'
) 

User.where(:email => 'chase.southard@cogitools.com').first.update_attribute :admin, true

Setting.create(
  :reg_available => true,
  :dtstart => "2012-04-02 00:00:00 -0400",
  :dtend => "2012-05-17 18:00:00 -0400",
  :max_capacity => 200
)