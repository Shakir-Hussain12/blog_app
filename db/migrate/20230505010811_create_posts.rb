class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :author_id
      t.string :title
      t.string :text
      t.integer :comments_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
