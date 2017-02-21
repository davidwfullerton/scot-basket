class AddCatalogEntryIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :catalog_entry_id, :integer
    remove_column :items, :vat, :float
    remove_column :items, :price, :float
    remove_column :items, :name, :string
    remove_column :items, :product_code, :integer
  end
end
