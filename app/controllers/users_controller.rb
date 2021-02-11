class UsersController < ApplicationController
  before_action :logged_in_user, only: %w[index edit update]
  before_action :correct_user, only: %w[:edit update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Oh mama, I wanna go surfing! Welcome ;)"
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
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    redirect_to login_path, notice: "Please Log In." unless logged_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user == @user
  end
end
