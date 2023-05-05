namespace :likes do
    desc "Update likes_count for all posts"
    task update_likes_count: :environment do
      Like.all.each do |like|
        like.post.increment!(:likes_count)
      end
    end
  end
  