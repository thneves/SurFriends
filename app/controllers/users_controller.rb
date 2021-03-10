class UsersController < ApplicationController
  before_action :logged_in_user, only: %w[index edit update following followers]
  before_action :correct_user, only: %w[:edit update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page]).includes(avatar_attachment: :blob)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @users = User.paginate(page: params[:page]).includes(avatar_attachment: :blob)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'Oh mama, I wanna go surfing! Welcome ;)'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page]).includes(avatar_attachment: :blob)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page]).includes(avatar_attachment: :blob)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user == @user
  end
end
