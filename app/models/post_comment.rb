# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_ancestry

  validates :content, presence: true

  def user
    User.find(self.user_id)
  end

  def descendant_comments
    self.child_ids.each_with_object([]) do |id, arr|
      arr << PostComment.find(id)
    end
  end
end
