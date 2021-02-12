class PostsController < ApplicationController
  before_action :logged_in_user, only: %w[create destroy]

  def index
  end

  def create
  end

  def destroy
  end
end