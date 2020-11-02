# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

3.times do |n|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 50 + rand(150)), email: "denis#{n += 1}@yopmail.com")
end

3.times do
  Event.create(start_date: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 60), duration: 25, title: Faker::Lorem.characters(number: 10), 
  description: "dhazjdhiuazdiuazuiduazuiduizaudaz", price: 50, location: "Paris", event_admin: User.all.sample)

end

3.times do
  Attendance.create(event_id: Event.all.sample.id, user_id: User.all.sample.id)
end
