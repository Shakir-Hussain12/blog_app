namespace :posts do
    desc "Update posts_count for all users"
    task update_posts_count: :environment do
      Post.all.each do |post|
        post.user.increment!(:posts_count)
      end
    end
  end
  