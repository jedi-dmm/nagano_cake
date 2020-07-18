class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

    	t.references :customer
    	t.string :postcode
    	t.string :address
    	t.string :name

      t.timestamps
    end
  end
end
