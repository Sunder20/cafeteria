class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    @current_user = User.find(session[:current_user_id])
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
      flash[:error] = "User Registered. Log-in to continue"
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to "/"
    end
  end

  def update
    id = params[:id]
    user = User.find(id)
    if user.clerk?
      user.role = "customer"
    elsif user.customer?
      user.role = "clerk"
    end
    user.save
    redirect_to users_path
  end

  def destroy
    id = params[:id]
    user = User.find(id)
    user.destroy
    redirect_to users_path
  end
end
