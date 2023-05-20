class PostsController < ApplicationController

  before_action :load_user, only: %i[index show create]
  def new; end

  def index
    @posts = @user.posts.includes(:comments).where(author_id: @user.id).paginate(page: params[:page], per_page: 2)
    render 'index', locals: { user: @user, posts: @posts }
  end

  def show
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def create
    title = params[:title]
    text = params[:text]
    @post = Post.new(title:, text:, likes_count: 0, comments_count: 0, author: @user)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_path(@post.author_id)
    else
      flash[:alert] = "Post couldn't be created"
      render 'new'
    end
  end

  private

  load_user = -> { @user = User.includes(:posts).find(params[:user_id]) }
  define_method :load_user, load_user
  
end
