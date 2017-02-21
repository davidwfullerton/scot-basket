# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

CatalogEntry.create!(product_code: 1, name: 'scotland_flag', price: 20, vat_rate: 0)
CatalogEntry.create!(product_code: 2, name: 'child_car_seat', price: 33.9, vat_rate: 0.05)
CatalogEntry.create!(product_code: 3, name: 'magnetic_wrist_band', price: 9, vat_rate: 0.2)
