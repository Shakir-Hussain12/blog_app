class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render 'show', locals: { myuser: @user, posts: @posts }
  end
end
