class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def create
    new_user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
    )
    if new_user.save
      flash[:error] = "User Registered. Sign-in to continue"
      redirect_to root_path
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
