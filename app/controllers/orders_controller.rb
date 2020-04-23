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
end
