class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?

  def common_item
　  $tax_rate = 0.1
　  $postage = 800
  end

end