class Customer::CostomersController < ApplicationController

  private
  def customer_params
  	  params.require(:customer).permit(:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :tel, :email, :password, :postcode, :address)
  end

end
