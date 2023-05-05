class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  recent_posts = ->(no) { posts.order(created_at: :desc).limit(no) }

  define_method :recent_posts, recent_posts
end
