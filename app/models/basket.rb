class Basket < ApplicationRecord
  has_many :items

=begin
scanning the code of a product creates an item by finding the equivilant
row in the catalog entry table. It creates this new item and calculates the
VAT that will be applied, storing this in the item entry. The item is
given the id of the current basket.
=end

  def scan(product_code)
    catalog_entries = CatalogEntry.where(product_code: product_code)
    if catalog_entries.count > 1
      raise 'Multiple catalog entries with same product code found'
    elsif catalog_entries.count < 1
      raise 'Invalid code given, no item added to basket'
    else
      catalog_entry = catalog_entries.first
      self.items.create!(product_code: product_code, name: catalog_entry.name, price: catalog_entry.price, vat: catalog_entry.price * catalog_entry.vat_rate)
    end
  end

  #calculates total price of items before any discounts or VAT.
  def subtotal
    if items.exists?
      items.pluck(:price).reduce(:+)
    else
      return 0
    end
  end

  #sums the total vat of all items in the basket
  def total_vat
    if items.exists?
      items.pluck(:vat).reduce(:+)
    else
      return 0
    end
  end

  #discount of £5 given for every second flag
  def flag_discount
    flag_count = items.where(product_code: 1).count
    (flag_count/2) * 5
  end

  #if subtotal + VAT - flagdiscount is over £70, %12 discount is applied
  def total_discount
    total = subtotal + total_vat - flag_discount
    if total > 70
      return (total) * 0.12
    else
      return 0
    end
  end

  #final total, including VAT and discounts. Rounded to 2 decimal places
  def total
    (subtotal + total_vat - flag_discount - total_discount)
  end

end
