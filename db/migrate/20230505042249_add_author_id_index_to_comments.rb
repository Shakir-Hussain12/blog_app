class AddAuthorIdIndexToComments < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, :author_id
    add_index :posts, :author_id
  end
end
