class ChangeAuthorIdTypeAndAddForeignKeyToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :author_id, :integer
    add_foreign_key :posts, :users, column: :author_id
  end
end
