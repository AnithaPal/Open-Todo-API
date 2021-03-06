# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

3.times do 
  user = User.new(
    username: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Lorem.characters(8))
  user.save!
end

user = User.new(
    username: 'Admin',
    email: 'admin@example.com',
    password: 'helloworld')
user.save!

users = User.all

5.times do 
  list = List.create!(
    user: users.sample,
    name: Faker::Lorem.sentence,
    permission: 'private')
end

5.times do 
  list = List.create!(
    user: users.sample,
    name: Faker::Lorem.sentence,
    permission: 'public')
end

lists = List.all

10.times do
  item = Item.create!(
    list: lists.sample,
    description: Faker::Lorem.sentence,
    completed: false,
    priority: Faker::Number.between(1, 5))
end

5.times do
  item = Item.create!(
    list: lists.sample,
    description: Faker::Lorem.sentence,
    completed: true,
    priority: Faker::Number.between(1, 5))
end

puts "Seed finsihed"
puts "#{User.count} users created"
puts "#{List.count} lists created"
puts "#{Item.count} items created"

