class OrdersController < ApplicationController
  def index
    if @current_user.admin?
      from = params[:from_date]
      to = params[:end_date]
      email = params[:email]
      unless from.nil?
        @order = Order.delivered.where("updated_at.to_date >= ? AND updated_at.to_date <= ?", from, to).reverse
      else
        @order = Order.all
      end

      render "admin"
    elsif @current_user.clerk?
      render "clerk"
    else
      @order_items = OrderItem.where(order_id: nil)
      render "customer"
    end
  end

  def show
    id = params[:id]
    @order = Order.find(id)
  end

  def new
    @new_order = Order.new()
    @new_order.user_id = @current_user.id
    @new_order.status = "pending"
    @new_order.save
    redirect_to menus_path
  end

  def update
    id = params[:id]
    order = Order.find(id)
    if @current_user.customer?
      order.status = "confirmed"
      order.save
      flash[:error] = " Order confirmed. Continue shoping "
      redirect_to menus_path
    elsif @current_user.clerk?
      order.status = params[:status]
      order.save
      redirect_to orders_path
    end
  end

  def edit
    id = params[:id]
    @order = Order.find(id)
  end

  def order_params
    params[:order].permit(:id, :status, :from_date, :end_date, :email, :updated_at)
  end
end
