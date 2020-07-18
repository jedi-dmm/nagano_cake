class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|

    	t.references :order
    	t.references :product
    	t.integer :product_quantity
    	t.integer :unit_price
    	t.integer :production_status

      t.timestamps
    end
  end
end
