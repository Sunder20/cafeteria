class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order

  def self.get_price(item)
    item.menu_item_price.to_i * item.quantity.to_i
  end

  def self.of_order(order)
    all.where(order_id: order.id)
  end
end
