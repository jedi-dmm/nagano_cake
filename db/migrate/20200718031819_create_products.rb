class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

    	t.references :genre
    	t.string :name
    	t.text :caption
    	t.integer :price
    	t.string :image_id
    	t.boolean :sale_status

      t.timestamps
    end
  end
end
