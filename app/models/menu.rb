class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy

  def self.active
    all.where(active: true).first
  end
end
