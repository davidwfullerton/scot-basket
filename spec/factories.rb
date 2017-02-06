FactoryGirl.define do

  #factory :catalog_flag_entry, class: CatalogEntry do
  #  product_code 1
  #  name "scotland_flag"
  #  price 20
  #  vat_rate 0
  #end

  factory :catalog_seat_entry, class: CatalogEntry do
    product_code 2
    name "child_car_seat"
    price 33.9
    vat_rate 0.05
  end

  #factory :catalog_band_entry, class: CatalogEntry do
  #  product_code 3
  #  name "magnetic_wrist_band"
  #  price 9
  #  vat_rate 0.2
  #end


  factory :item_1, class: Item do
    basket
    product_code 1
    name "scotland_flag"
    price 20
    vat 0
  end

  factory :item_2, class: Item do
    basket
    product_code 2
    name "child_car_seat"
    price 33.9
    vat 1.695
  end

  factory :item_3, class: Item do
    basket
    product_code 3
    name "magnetic_wrist_band"
    price 9
    vat 1.8
  end

  factory :basket do
    transient do
      item_1_amount 0
      item_2_amount 0
      item_3_amount 0
    end

    after(:create) do |basket, evaluator|
      create_list(:item_1, evaluator.item_1_amount, basket: basket)
      create_list(:item_2, evaluator.item_2_amount, basket: basket)
      create_list(:item_3, evaluator.item_3_amount, basket: basket)
    end
  end
end
