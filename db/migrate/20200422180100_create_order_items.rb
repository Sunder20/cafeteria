class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.bigint :order_id
      t.bigint :menu_item_id
      t.text :menu_item_name
      t.text :menu_item_description
      t.text :menu_item_price
      t.bigint :quantity
    end
  end
end
