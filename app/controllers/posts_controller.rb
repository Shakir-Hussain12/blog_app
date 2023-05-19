class PostsController < ApplicationController
  def new; end

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
    render 'index', locals: { user: @user, posts: @posts }
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def create
    title = params[:title]
    text = params[:text]
    @post = Post.new(title:, text:, likes_count: 0, comments_count: 0, author: current_user)
    if @post.save
      puts 'success!'
      flash[:success] = 'Post created successfully'
      redirect_to user_path(@post.author_id)
    else
      puts 'failure!'
      flash[:alert] = "Post couldn't be created"
      render 'new'
    end
  end
end
