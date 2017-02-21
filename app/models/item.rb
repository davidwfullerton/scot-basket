class Item < ApplicationRecord
  belongs_to :basket
  belongs_to :catalog_entry

  def vat
    catalog_entry.price * catalog_entry.vat_rate
  end
end
