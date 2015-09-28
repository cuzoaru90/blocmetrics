# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

User.destroy_all

10.times do
  user = User.new( name:     Faker::Name.name,
                   email:    Faker::Internet.email,
                   password: 'helloworld' )
  user.skip_confirmation!
  user.save!
end

user = User.new( name:     'Chuck Uzoaru', 
                 email:    'cuzoaru90@gmail.com', 
                 password: 'helloworld' )
user.skip_confirmation!
user.save!

user.registered_applications.create!( name: "Sample Registered Application", 
                                      url:  "http://registered_application.com" )

users = User.all

users.each do | user | 
  user.registered_applications.create!( name: Faker::Lorem.word, 
                                        url:  Faker::Internet.url )
end



registered_applications = RegisteredApplication.all

registered_applications.each do | app |
  r = Random.new
  num = r.rand(1...8)

  num.times do
    app.events.create!( name: Faker::Lorem.sentence )
  end
end

user.registered_applications.create!( name: "Bloccit", 
                                      url:  "http://localhost:3000" )

user.registered_applications.create!( name: "Blocipedia", 
                                      url:  "http://localhost:3500" )



