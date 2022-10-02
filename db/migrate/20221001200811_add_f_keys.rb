class AddFKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :post_comments, :users
    add_foreign_key :post_comments, :posts
    add_foreign_key :post_likes, :users
    add_foreign_key :post_likes, :posts
    add_foreign_key :posts, :categories
    add_foreign_key :posts, :users, column: :creator_id
  end
end
