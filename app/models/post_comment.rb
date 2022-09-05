# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_ancestry

  validates :content, presence: true
end
