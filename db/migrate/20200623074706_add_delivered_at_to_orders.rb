class AddDeliveredAtToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivered_at, :datetime
  end
end
