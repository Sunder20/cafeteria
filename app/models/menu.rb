class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy
  validates :name, uniqueness: { case_sensitive: false }

  def self.active
    all.where(active: true).first
  end
end
