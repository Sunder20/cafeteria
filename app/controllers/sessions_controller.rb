class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to menus_path
    else
      flash[:error] = "Your login attempt was invalid. Please retry"
      redirect_to root_path
    end
  end

  def destroy
    @current_user = User.find(session[:current_user_id])
    if @current_user.customer?
      OrderItem.where(order_id: nil).delete_all
    end
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to root_path
  end
end
