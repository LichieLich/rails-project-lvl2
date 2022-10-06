# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes, class_name: 'PostLike', dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :posts, class_name: 'Post', foreign_key: 'creator_id', dependent: :destroy
end
