class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

	def common_item
	　$tax_rate = 0.1
	　$postage = 800
	end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana, :tel, :postcode, :address])
  end

end
