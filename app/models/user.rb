class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  def admin?
    role == "admin"
  end

  def clerk?
    role == "clerk"
  end
end
