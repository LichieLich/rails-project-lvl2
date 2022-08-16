# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  has_many :post_comments

  validates :title, :creator, presence: true
end
