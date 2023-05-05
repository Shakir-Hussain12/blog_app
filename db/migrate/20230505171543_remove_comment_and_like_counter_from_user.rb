class RemoveCommentAndLikeCounterFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :comments_count, :integer
    remove_column :users, :likes_count, :integer
  end
end
