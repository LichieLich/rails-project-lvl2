# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def user
    User.find(self.user_id)
  end
end
