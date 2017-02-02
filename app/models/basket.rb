class Basket < ApplicationRecord
  has_many :items

  def scan(product_code)
    catalog_entries = CatalogEntry.where(product_code: product_code)
    if catalog_entries.count > 1
      Rails.logger.error('Multiple catalog entries with same product code found')
    elsif catalog_entries.count < 1
      Rails.logger.error('Invalid code given, item not added to basket')
    else
      catalog_entry = catalog_entries.first
      self.items.create!(product_code: product_code, name: catalog_entry.name, price: catalog_entry.price, vat: catalog_entry.price * catalog_entry.vat_rate)
    end
  end
end
