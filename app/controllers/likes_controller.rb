class LikesController < ApplicationController
  def create
    puts 'starting to create'
    @post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)
    if @like.save
      puts 'created'
      flash.now[:success] = 'You just liked this post...'
      redirect_to user_post_path(@like.author_id, @like.post_id)
    else
      puts 'failed'
      flash[:alert] = 'Like unsuccessful...'
    end
  end
end
