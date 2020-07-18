class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.references :customer
    	t.integer :payment
    	t.integer :postage
    	t.integer :order_status
    	t.string :name
    	t.string :postcode
    	t.string :address

      t.timestamps
    end
  end
end
