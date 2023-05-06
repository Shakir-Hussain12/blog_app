class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'

  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_count, numericality: { greater_than_or_equal_to: 0 }
  validates :comments_count, numericality: { greater_than_or_equal_to: 0 }

  recent_comments = ->(no) { comments.order(created_at: :desc).limit(no) }

  define_method :recent_comments, recent_comments

  after_save :update_count

  private

  def update_count
    return unless author.posts.count(:all) == 1

    author.increment!(:posts_count)
  end
end
