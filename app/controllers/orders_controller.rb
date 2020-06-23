class OrdersController < ApplicationController
  def index
    if @current_user.admin?
      if params[:admin]
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
          @order = Order.delivered.where(updated_at: @from..till)
        else
          @order = Order.delivered.where(updated_at: @from..till, user_id: user.id)
        end
        @order = @order.order("updated_at DESC")
        render "admin"
      else
        render "clerk"
      end
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
    @new_order.user_id = @current_user.id
    @new_order.status = "unconfirmed"
    @new_order.save
    puts @new_order.user_id
    if @current_user.customer?
      redirect_to menus_path
    else
      redirect_to menus_path(:walkin => true)
    end
  end

  def update
    id = params[:id]
    order = Order.find(id)
    if @current_user.customer?
      if order.user_id == @current_user.id && order.unconfirmed?
        order.update(status: "confirmed")
        order.placed_at = order.updated_at
        order.save
        flash[:success] = " Order confirmed. Continue shopping "
        redirect_to menus_path
      else
        flash[:error] = " Bad Parameters"
      end
    else
      if params[:walkin]
        if order.user_id == @current_user.id && order.unconfirmed?
          order.update(status: "confirmed", user_id: 2)
          order.placed_at = order.updated_at
          order.save
          flash[:success] = " Order confirmed "
          redirect_to orders_path
        else
          flash[:error] = " Bad Parameters"
        end
      else
        if order.ready?
          order.update(status: "delivered")
          order.delivered_at = order.updated_at
        elsif order.confirmed?
          order.status = "ready"
        end
        order.save
        redirect_to orders_path
      end
    end
    # end
  end

  def edit
    id = params[:id]
    @order = Order.of_user(@current_user).find(id)
    @orderitems = OrderItem.where(order_id: @order.id).all
  end

  def destroy
    id = params[:id]
    if @current_user.customer?
      order = Order.of_user(@current_user).find(id)
    else
      user = User.find(2)
      order = Order.of_user(user).find(id)
    end
    order.destroy
    if @current_user.customer?
      redirect_to menus_path
    elsif @current_user.clerk?
      redirect_to menus_path(:walkin => true)
    end
  end

  def order_params
    params[:order].permit(:id, :status, :from_date, :end_date, :email, :updated_at, :walkin, :admin)
  end
end
