class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id', counter_cache: true
  
  after_save :update_count
  
  private

  def update_count
    post.increment!(:likes_count)
  end
  
end
