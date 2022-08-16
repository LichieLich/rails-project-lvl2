class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.references :post

      t.text :content, null: false
      
      t.timestamps
    end
  end
end
