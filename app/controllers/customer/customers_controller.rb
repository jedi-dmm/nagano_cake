class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!

	def show
		@customer = Customer.find(current_customer.id)
	end

	def edit
		@customer = Customer.find(current_customer.id)
	end

	def update
		@customer = Customer.find(current_customer.id)
		if @customer.update(customer_params)
			redirect_to customer_path
		else
			render :edit
		end
	end

	def leave

	end

	def hide
        @customer = Customer.find(current_customer.id)
        @customer.update(customer_status: false)
        reset_session
        flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to root_path
    end

	private
 	def customer_params
  	  params.require(:customer).permit(:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :tel, :email, :password, :postcode, :address, :customer_status)
	end
end
