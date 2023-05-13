class CommentsController < ApplicationController
  def new; end

  def create
    @post = Post.find(params[:post_id])
    text = comment_params
    @comment = Comment.new(text:, post: @post, author: current_user)
    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      flash[:alert] = "Comment couldn't be created"
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:text)
  end
end
