class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password
  has_many :orders

  def admin?
    role == "admin"
  end

  def clerk?
    role == "clerk"
  end
end
