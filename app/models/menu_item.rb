class MenuItem < ApplicationRecord
  belongs_to :menu

  def self.of_menu(menu_id)
    all.where(menu_id: menu_id)
  end
end
