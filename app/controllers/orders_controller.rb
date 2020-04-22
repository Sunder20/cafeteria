class OrdersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render "admin"
  end
end
