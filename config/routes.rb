Rails.application.routes.draw do

  devise_for :users
  namespace :admin do
    resources :products

    resources :users do
      member do # 對單筆資料進行處理
      post :to_admin
      post :to_normal
      end
    end

    resources :orders

  end

  resources :products do
    member do # 對單筆資料進行處理
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      post :checkout   # 訂單確認頁面路徑為checkout
      delete :clean    # 清空購物車內容路徑為clean
    end
  end

  resources :orders do
    member do
      get :pay_with_credit_card
    end
  end

  # 將建立的cart_items controller 對應的路徑命名為items
  resources :items, controller: "cart_items"

  namespace :account do
    resources :orders
  end

  root "products#index"


end
