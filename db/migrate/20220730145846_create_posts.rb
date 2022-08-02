class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :category
      t.string :title
      t.string :body
      t.string :creator

      t.timestamps
    end
  end
end
