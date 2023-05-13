class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.where(id: params[:id])
    @posts = Post.where(author_id: @user[0].id)
    render 'show', locals: { myuser: @user, posts: @posts }
  end
end
