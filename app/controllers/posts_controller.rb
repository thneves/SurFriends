class PostsController < ApplicationController
  before_action :logged_in_user, only: %w[create destroy]

  def index
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created! I'm Stoked!!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end