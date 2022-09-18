# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, :body, presence: true

  def user
    User.find(creator)
  end

  def like_by_user(user)
    likes.find_by(user_id: user.id || nil)
  end
end
