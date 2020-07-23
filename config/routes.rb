Rails.application.routes.draw do

	devise_for :customers, controllers: {
    sessions: "customer/devise/sessions",
    passwords: "customer/devise/passwords",
    registrations: "customer/devise/registrations"
  }
	devise_for :admins, controllers: {
    sessions: "admin/devise/sessions",
    passwords: "admin/devise/passwords",
    registrations: "admin/devise/registrations"
  }

	root 'customer/homes#top'


	  get 'homes/about' => 'customer/homes#about', as: 'about'
	  delete 'carts/delete' => 'customer/carts#destroy_all', as: 'destroy_carts'
	  post 'orders/confirm'  => 'customer/orders#confirm', as: 'confirm'
	  get 'orders/thanks'  => 'customer/orders#thanks', as: 'thanks'
	  get 'customers/leave' => 'customer/customers#leave', as: 'leave'
	  patch 'customers/hide' => 'customer/customers#hide', as: 'hide'

	scope module: :customer do
	    resources :products, only: [:show, :index]
	    resources :carts, only: [:index, :create, :destroy, :update]
	    resources :orders, only: [:show, :index, :new, :create]
	    resource :customer, only: [:show]
	    resources :posts, only: [:index, :create, :edit, :destroy, :update]
	end


	namespace :admin do
	    resources :genres, only: [:create, :index, :edit, :update]
	    resources :customers, only: [:show, :index, :edit, :update]
	    resources :orders, only: [:show, :index, :update]
	    resources :products, only: [:new, :show, :index, :edit, :create, :update]
	    resources :order_products, only: [:update]
	end

    get 'admins/home/top' => 'admin/homes#top', as: 'admin_top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
