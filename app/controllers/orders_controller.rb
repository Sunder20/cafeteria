class OrdersController < ApplicationController
  def index
    if @current_user.admin?
      @from = params[:from_date]
      @to = params[:end_date]
      email = params[:email]
      user = User.find_by(email: email)
      if @from.nil?
        @from = (DateTime.now.to_date).to_s
        @to = (DateTime.now.to_date + 1).to_s
      end
      till = (DateTime.parse(@to).to_date + 1).to_s
      if user.nil?
        puts @from
        @order = Order.where(updated_at: @from..till)
        puts @to.class
      else
        @order = Order.where(updated_at: @from..till, user_id: user.id)
      end
      @order = @order.order("updated_at DESC")
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
    @orderitems = OrderItem.where(order_id: @order.id).all
  end

  def new
    @new_order = Order.new()
    if @current_user.customer?
      @new_order.user_id = @current_user.id
    elsif @current_user.clerk?
      @new_order.user_id = 2
    end
    @new_order.status = "pending"
    @new_order.save
    puts @new_order.user_id
    if @current_user.customer?
      redirect_to menus_path
    elsif @current_user.clerk?
      redirect_to menus_path(:walkin => true)
    end
  end

  def update
    id = params[:id]
    order = Order.find(id)
    if order.user_id == 2
      if params[:walkin]
        order.status = params[:status]
        order.save
        redirect_to orders_path
      else
        order.status = "confirmed"
        order.save
        flash[:error] = " Order confirmed"
        redirect_to orders_path
      end
    else
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
  end

  def edit
    id = params[:id]
    @order = Order.find(id)
    @orderitems = OrderItem.where(order_id: @order.id).all
  end

  def destroy
    id = params[:id]
    order = Order.find(id)
    order.destroy
    if @current_user.customer?
      redirect_to menus_path
    elsif @current_user.clerk?
      redirect_to menus_path(:walkin => true)
    end
  end

  def order_params
    params[:order].permit(:id, :status, :from_date, :end_date, :email, :updated_at, :walkin)
  end
end
