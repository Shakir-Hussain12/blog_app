module CommentHelper
    def show_comments(post)
      comments = Comment.where(post_id: post.id)
      if post.comments_count.nil?
        content_tag(:p, "No Comments Yet!")
      else
        output = content_tag(:h3, "")
        comments.each do |comment|
          user = User.find(comment.author_id)
          comment_html = content_tag(:p, "#{user.name}: #{comment.text}")
          output += content_tag(:li, comment_html, class: "comment-item")
        end
        output
      end
    end
  end