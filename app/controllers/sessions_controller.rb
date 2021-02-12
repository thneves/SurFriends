class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      # Create an error message.
      flash.now[:error] = "Invalid email or password! you're not surfing yet" # Not quite right yet
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil
    flash.now[:danger] = "Swell is over! You are logged out"
    redirect_to root_path
  end
end
