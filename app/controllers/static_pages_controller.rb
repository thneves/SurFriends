class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).includes(:user)
      @users = User.all.order(created_at: :desc)
    end
    
  end

  def about
  end
end
