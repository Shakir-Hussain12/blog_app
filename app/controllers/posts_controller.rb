class PostsController < ApplicationController
  def index; end

  def show; end

  def create
    title = post_params[:title]
    text = post_params[:text]
    @post = Post.new(title:, text:, author: current_user)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      flash[:alert] = "Post couldn't be created"
      render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:text, :title)
  end
end
