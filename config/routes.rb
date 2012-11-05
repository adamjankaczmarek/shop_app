ShopApp::Application.routes.draw do
  
  # Admin section
  namespace :admin do
    devise_for :admin_users
    root :to => "orders#index"
    match "orders/show" => "orders#show"
    resources :shop, :categories, :products, :orders
  end

  
  root :to => "shop#index" 
  get "shop/index"
  
  resources :categories, :products, :orders
  # Products Controller Routes
  #match 'products/' => "products#index"
  #match 'product/:id' => "products#show"
  # Categories Controller Routes
  #match "categories/" => "categories#index"
  #match "categories/:id" => "categories#show"
  # Orders Controller Routes
  match "orders/add/:product_id" => "orders#add_product"
  match "orders/show" => "orders#show"
  match "orders/remove/:order_item_id" => "orders#remove_item"
  match "orders/confirm/:id" => "orders#confirm"
  match "products_search" => "products#search"
  match "hello" => 'hello#greeting'

end
