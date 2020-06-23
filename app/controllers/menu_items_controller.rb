class MenuItemsController < ApplicationController
  def index
    id = params[:id]
    @items = MenuItem.of_menu(id)
    @menu = Menu.find(id)
    if @menu.nil?
      puts "nil"
    else
      render "admin"
    end
  end

  def create
    new_item = MenuItem.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      menu_id: params[:id],
      image_id: params[:image_id],
    )
    if new_item.save
      redirect_to menu_items_path(:id => new_item.menu_id)
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menu_items_path(:id => new_item.menu_id)
    end
  end

  def new
    id = params[:id]
    @menu = Menu.find(id)
  end

  def update
    id = params[:id]
    item = MenuItem.find(id)
    if item.name != params[:name] && params[:name] != ""
      item.name = params[:name]
    end

    if item.price != params[:price] && params[:price] != ""
      item.price = params[:price]
    end

    if item.description != params[:description] && params[:description] != ""
      item.description = params[:description]
    end

    if item.image_id != params[:image_id] && params[:image_id] != ""
      item.image_id = params[:image_id]
    end

    item.save!
    redirect_to menu_items_path(:id => item.menu_id)
  end

  def edit
    id = params[:id]
    @item = MenuItem.find(id)
  end

  def destroy
    id = params[:id]
    item = MenuItem.find(id)
    menu_id = item.menu_id
    item.destroy
    redirect_to menu_items_path(:id => item.menu_id)
  end
end
