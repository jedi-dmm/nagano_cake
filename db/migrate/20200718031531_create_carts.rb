class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|

    	t.references :customer
    	t.references :product
    	t.integer :product_quantity

      t.timestamps
    end
  end
end
