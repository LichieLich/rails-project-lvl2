# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Рубокоп не пускает без уникального индекса
  # validates :user_id, uniqueness: { scope: :post_id,
  #                                   message: 'You can like a post only once' }
end
