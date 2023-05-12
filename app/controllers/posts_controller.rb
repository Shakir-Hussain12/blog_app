class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    render 'index', locals: {user: @user, posts: @posts}
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
