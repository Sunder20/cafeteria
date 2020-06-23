class AddPlacedAtToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :placed_at, :datetime
  end
end
