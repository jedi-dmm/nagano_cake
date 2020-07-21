class Admin::CustomersController < ApplicationController
	def index
		@customers = Cusromer.page(params[:page]).reverse_order
	end

	def show
		@customer = Customer.find(params[:id])
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			redirect_to _path(customer.id), notice: '会員情報を更新しました。'
		else
			render :edite
		end
	end

	private

	def customer_params
	    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :tel, :email, :is_enabled)
	end

end
