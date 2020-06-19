class OrdersController < ApplicationController
  def index
    if @current_user.admin?
      render "admin"
    elsif @current_user.clerk?
      render "clerk"
    else
      @order_items = OrderItem.where(order_id: nil)
      render "customer"
    end
  end

  def new
    @new_order = Order.new
  end

  def create
    @new_order = Order.new()
    @new_order.user_id = @current_user.id
    @new_order.status = "pending"
    @new_order.save
    redirect_to menus_path
  end
end
