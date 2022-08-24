# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  validates :title, :creator, presence: true
end
