class MenuItem < ApplicationRecord
  belongs_to :menu
  has_one_attached :image
  #mount_uploader :image, ImageUploader

  def self.of_menu(menu_id)
    all.where(menu_id: menu_id)
  end
end
