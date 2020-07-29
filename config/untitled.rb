Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  
  # ec-site
  get 'homes#top'
  get 'homes#about'
  resources :products,only: [:index,:show]
  resource :carts,only: [:show,:create,:destroy,:update] do
  	member do
  		delete 'carts#delete'
  	end
  end
  resources :orders,only: [:new,:create,:index,:show] do
  	member do
  		get 'orders#confirm'
  		get 'orders#thanks'
  	end
  end
  resource :customers,only: [:show,:edit,:udate] do
  	member do
  		get 'customers#leave'
  		patch 'customers#hide'
  	end
  end
  resource :posts, only: [:create,:show,:destroy,:edit,:update]
end
