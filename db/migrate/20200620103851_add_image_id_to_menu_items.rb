class AddImageIdToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :image_id, :string
  end
end
