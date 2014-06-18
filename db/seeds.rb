# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Admin.create :email => 'info@gamify.com', :password => 'Admin@123', :password_confirmation => 'Admin@123'

puts "Admin: info@gamify.com"
puts "Password: Admin@123"
