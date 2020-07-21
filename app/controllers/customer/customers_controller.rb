class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!

	def show
		@customer = Customer.find(current_customer.id)
	end

	def edit
		@customer = Customer.find(current_customer.id)
	end

	def update

	end

	def leave

	end

	def hide
        @customer = Customer.find(current_customer.id)
        #is_deletedカラムにフラグを立てる(defaultはfalse)
        @customer.update(customer_status: true)
        #ログアウトさせる
        reset_session
        flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to new_customer_registration_path
    end

	private
 	def customer_params
  	  params.require(:customer).permit(:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :tel, :email, :password, :postcode, :address)
	end
end
