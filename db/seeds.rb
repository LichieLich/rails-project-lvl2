# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Categories
5.times do
  Category.create name: Faker::Beer.brand
end

# Users
5.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.save
end

# Posts
5.times do
  body = Faker::Lorem.paragraph(sentence_count: rand(25)) if rand(2) > 0
  Post.create title: Faker::BossaNova.artist, creator: User.all.sample.email, category: Category.all.sample, body: body
end