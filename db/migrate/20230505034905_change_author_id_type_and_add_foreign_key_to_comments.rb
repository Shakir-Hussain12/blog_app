class ChangeAuthorIdTypeAndAddForeignKeyToComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :author_id, 'integer USING author_id::integer'
    add_foreign_key :comments, :users, column: :author_id
  end
end
