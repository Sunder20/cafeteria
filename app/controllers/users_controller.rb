class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render "clerk"
  end

  def create
    new_user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      role: params[:role],
    )
    if new_user.save
      flash[:error] = "User Registered. Sign-in to continue"
      redirect_to root_path
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end
end
