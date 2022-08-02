class Post < ApplicationRecord
  belongs_to :category

  validates :title, :creator, :category, presence: true
end
