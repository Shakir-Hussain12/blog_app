class ChangePostAndCommentContentSize < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :text, :text
    change_column :comments, :text, :text
  end
end
