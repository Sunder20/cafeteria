class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :orders

  def admin?
    role == "admin"
  end

  def clerk?
    role == "clerk"
  end

  def customer?
    role == "customer"
  end

  def self.customer
    all.where(role: "customer")
  end

  def self.clerk
    all.where(role: "clerk")
  end
end
