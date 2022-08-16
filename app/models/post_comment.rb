class PostComment < ApplicationRecord
  belongs_to :post
  has_ancestry

  validates :content, presence: true
end
