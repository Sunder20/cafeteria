class OrderItemsController < ApplicationController
  def create
    id = params[:id]
    order_id = params[:order_id]
    if OrderItem.find_by(menu_item_id: id, order_id: order_id)
      order_item = OrderItem.find_by(menu_item_id: id, order_id: order_id)
      order_item.quantity = order_item.quantity + 1
      order_item.save
      if @current_user.customer?
        redirect_to menus_path
      elsif @current_user.clerk?
        redirect_to menus_path(:walkin => true)
      end
    else
      item = MenuItem.find(params[:id])
      OrderItem.create!(
        order_id: params[:order_id],
        menu_item_name: item.name,
        menu_item_price: item.price,
        menu_item_description: item.description,
        menu_item_id: item.id,
        quantity: 1,
      )
      if @current_user.customer?
        redirect_to menus_path
      elsif @current_user.clerk?
        redirect_to menus_path(:walkin => true)
      end
    end
  end

  def update
    order_item = OrderItem.find_by(menu_item_id: params[:id], order_id: params[:order_id])
    order_item.quantity = order_item.quantity - 1
    order_item.save
    if order_item.quantity == 0
      order_item.destroy
    end
    if @current_user.customer?
      redirect_to menus_path
    elsif @current_user.clerk?
      redirect_to menus_path(:walkin => true)
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    if @current_user.customer?
      redirect_to menus_path
    elsif @current_user.clerk?
      redirect_to menus_path(:walkin => true)
    end
  end
end
