class Comment < ApplicationRecord
    belongs_to :author, class_name: "User", foreign_key: "author_id"
    belongs_to :post, foreign_key: "post_id", counter_cache: true

    after_create do
        post.increment!(:comments_count)
    end

end
