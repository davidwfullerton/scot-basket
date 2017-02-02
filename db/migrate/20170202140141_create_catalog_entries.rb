class CreateCatalogEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :catalog_entries do |t|
      t.integer :product_code
      t.string :name
      t.float :price
      t.float :vat_rate

      t.timestamps
    end
  end
end
