class AddPostsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :user, null: false
  end
end
