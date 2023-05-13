class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).paginate(page: params[:page], per_page: 2)
    render 'index', locals: { user: @user, posts: @posts }
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

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
