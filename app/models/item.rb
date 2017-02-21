class Item < ApplicationRecord
  belongs_to :basket
  belongs_to :catalog_entry

  def name
    catalog_entry.name
  end

  def product_code
    catalog_entry.product_code
  end

  def price
    catalog_entry.price
  end

  def vat
    catalog_entry.price * catalog_entry.vat_rate
  end
end
