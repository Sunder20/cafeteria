class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def self.pending
    all.where(status: "pending")
  end

  def self.confirmed
    all.where(status: "confirmed")
  end

  def self.delivered
    all.where(status: "delivered")
  end

  def pending?
    status == "pending"
  end

  def confirmed?
    status == "confirmed"
  end

  def delivered?
    status == "delivered"
  end

  def self.today
    all.where(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
