class UsersController < ApplicationController
  def index
    if @current_user.admin?
      render "clerk"
    end
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
      redirect_to "/"
    end
  end

  def destroy
    id = params[:id]
    user = User.find(id)
    user.destroy
    redirect_to users_path
  end
end
