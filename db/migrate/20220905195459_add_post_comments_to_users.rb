class AddPostCommentsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_comments, :user, null: false
  end
end
