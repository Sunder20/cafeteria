class MenusController < ApplicationController
  def index
    if @current_user.admin?
      if params[:walkin]
        @order = Order.where(user_id: @current_user.id, status: "unconfirmed").first
        if @order.nil?
          redirect_to new_order_path
        else
          @orderitems = OrderItem.where(order_id: @order.id).all
          render "customer"
        end
      else
        render "admin"
      end
    elsif @current_user.clerk?
      if params[:walkin]
        @order = Order.where(user_id: @current_user.id, status: "unconfirmed").first
        if @order.nil?
          redirect_to new_order_path
        else
          @orderitems = OrderItem.where(order_id: @order.id).all
          render "customer"
        end
      else
        redirect_to orders_path
      end
    else
      @order = Order.where(user_id: @current_user.id, status: "unconfirmed").first
      if @order.nil?
        redirect_to new_order_path
      else
        @orderitems = OrderItem.where(order_id: @order.id).all
        render "customer"
      end
    end
  end

  def create
    if Menu.first
      active = false
    else
      active = true
    end
    new_menu = Menu.new(
      name: params[:name],
      active: active,
    )
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def update
    id = params[:id]
    active = params[:active]
    name = params[:name]
    menu1 = Menu.find(id)
    if name
      menu1.update(name: name )
      redirect_to menu_items_path(:id => menu1.id)
    elsif active
      menu0 = Menu.where(active: active).first

      menu0.active = false
      menu1.active = true
      menu0.save
      menu1.save
      redirect_to menus_path
    else
      flash[:error] = "There must be atleast one active menu"
      redirect_to menus_path
    end
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    if menu.active
      menu1 = Menu.where(active: false).first
      unless menu1.nil?
        menu1.active = true
        menu1.save
        menu.destroy
      else
        flash[:error] = "One active menu is needed"
      end
    else
      menu.destroy
    end
    redirect_to menus_path
  end
end
