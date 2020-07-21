class Admin::HomesController < ApplicationController

  def top
  	@order = Order.where(created_at: rand)
  end

end
