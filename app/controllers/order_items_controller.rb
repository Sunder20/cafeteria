class OrderItemsController < ApplicationController
  def create
    id = params[:id]
    order_id = params[:order_id]
    if OrderItem.find_by(menu_item_id: id)
      order_item = OrderItem.find_by(menu_item_id: id)
      order_item.quantity = order_item.quantity + 1
      order_item.save
      redirect_to menus_path
    else
      item = MenuItem.find(params[:id])
      OrderItem.create!(
        order_id: order_id,
        menu_item_name: item.name,
        menu_item_price: item.price,
        menu_item_description: item.description,
        menu_item_id: item.id,
        quantity: 1,
      )
      redirect_to menus_path
    end
  end

  def update
    order_item = OrderItem.find_by(menu_item_id: params[:id])
    order_item.quantity = order_item.quantity - 1
    order_item.save
    if order_item.quantity == 0
      order_item.destroy
    end
    redirect_to menus_path
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    redirect_to menus_path
  end
end
