class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'

  after_create do
    author.increment!(:posts_count)
  end

  recent_comments = ->(no) { comments.order(created_at: :desc).limit(no) }

  define_method :recent_comments, recent_comments
end
