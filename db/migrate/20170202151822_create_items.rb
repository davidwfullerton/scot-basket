class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :basket_id
      t.integer :product_code
      t.string :name
      t.float :price
      t.float :vat

      t.timestamps
    end
  end
end
