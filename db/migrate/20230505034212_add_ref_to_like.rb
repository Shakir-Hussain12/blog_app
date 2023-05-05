class AddRefToLike < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :post, null: false, foreign_key: true
    add_reference :likes, :author, null: false, foreign_key: { to_table: :users, column: :id }
  end
end
