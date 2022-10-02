# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_likes, class_name: 'PostLike', dependent: :destroy
  has_many :post_comments, class_name: 'PostComment', dependent: :destroy
  has_many :posts, class_name: 'Post', dependent: :destroy
end
