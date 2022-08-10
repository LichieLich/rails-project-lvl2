# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category

  validates :title, :creator, presence: true
end
