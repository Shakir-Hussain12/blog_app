class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_initialize :set_name

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id', through: :posts
  has_many :likes, foreign_key: 'author_id', through: :posts

  validates :name, presence: true
  validates :posts_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def set_name
       self.name ||= email.split('@').first || 'Anonymous'
  end

  recent_posts = ->(no) { posts.order(created_at: :desc).limit(no) }
  define_method :recent_posts, recent_posts
end
