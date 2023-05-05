namespace :comments do
    desc "Update comments_count for all posts"
    task update_comments_count: :environment do
      Comment.all.each do |comment|
        comment.post.increment!(:comments_count)
      end
    end
  end
  