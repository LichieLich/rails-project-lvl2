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
users = User.all

# Posts
5.times do
  body = Faker::Lorem.paragraph(sentence_count: rand(25))
  Post.create title: Faker::BossaNova.artist, user_id: users.sample.id, category: Category.all.sample, body: body
end

# Comments
posts = Post.all
10.times do
  post = posts.sample
  post.comments.build(content: Faker::ChuckNorris.fact, user_id: users.sample.id).save
end

# Comments' replys
25.times do
  comments = PostComment.all
  ancestor = comments.sample
  ancestor.children.create(content: Faker::ChuckNorris.fact, post_id: ancestor.post_id, user_id: users.sample.id)
end

# Likes
posts = Post.all
posts.each do |post|
  users.each do |user|
    post.likes.build(post_id: post.id, user_id: user.id).save if rand(100) > 75
  end
end
