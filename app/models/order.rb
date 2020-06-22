class Order < ApplicationRecord
  attr_accessor :from_date, :end_date
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def self.get_sum(order)
    sum = 0
    order_items = OrderItem.of_order(order)
    order_items.each do |item|
      sum = sum + OrderItem.get_price(item)
    end
    return sum
  end

  def self.of_user(user)
    all.where(user_id: user.id)
  end

  def self.of_user(user)
    all.where(user_id: user.id)
  end

  def self.unconfirmed
    all.where(status: "unconfirmed")
  end

  def self.confirmed
    all.where(status: "confirmed")
  end

  def self.ready
    all.where(status: "ready")
  end

  def self.delivered
    all.where(status: "delivered")
  end

  def unconfirmed?
    status == "unconfirmed"
  end

  def confirmed?
    status == "confirmed"
  end

  def ready?
    status == "ready"
  end

  def delivered?
    status == "delivered"
  end

  def self.today
    all.where(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
