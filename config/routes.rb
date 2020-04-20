Rails.application.routes.draw do
  root to: "home#index"
  resources :menus
  resources :menu_items
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
