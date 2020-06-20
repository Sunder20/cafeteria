class RemoveImageFromMenuItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :menu_items, :image, :string
  end
end
