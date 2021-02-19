class StaticPagesController < ApplicationController
  def home
    @post = current_user.posts.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?
    @users = User.all.order(created_at: :desc)
  end

  def about
  end
end
