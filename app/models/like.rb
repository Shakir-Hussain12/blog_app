class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'

  after_save :update_count

  private

  def update_count
    post.update(likes_count: post.likes.count)
  end
end
