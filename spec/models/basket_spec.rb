require 'rails_helper'
require 'support/factory_girl'

describe Basket do
  describe '#scan(product_code)' do
    let(:basket){FactoryGirl.create(:basket)}

    context 'when a child seat is scanned' do
      let!(:seat) {FactoryGirl.create(:catalog_seat_entry)}
      before {basket.scan(seat.product_code)}

      subject{basket.items.first}
      
      it 'will have an item' do
        expect(basket.items.count).to equal(1)
      end

      it 'will have an item with product code for a seat' do
        expect(subject.catalog_entry.product_code).to eq(seat.product_code)
      end

      it 'will have an item with name of a seat' do
        expect(subject.catalog_entry.name).to eq(seat.name)
      end

      it 'will have an item with the price for a seat' do
        expect(subject.catalog_entry.price).to eq(seat.price)
      end

      it 'will have an item with VAT price for a seat' do
        expect(subject.vat).to eq(seat.vat_rate * seat.price)
      end
    end 

    context 'when an invalid item is scanned' do
      it 'will raise an error' do
        expect{basket.scan(1)}.to raise_error("Invalid code given, no item added to basket")
      end
    end

    context 'when multiple catalog entries are found' do
      before do
        2.times do
          FactoryGirl.create(:catalog_seat_entry)
        end
      end
      it 'will raise an error' do
        expect{basket.scan(CatalogEntry.first.product_code)}.to raise_error("Multiple catalog entries with same product code found")
      end
    end

    context 'when nothing scanned' do
      it 'will have no items' do
        expect(basket.items.count).to equal(0)
      end
    end
  end

  describe 'price calculations' do
    context 'when basket contains products 1,2,3' do
      subject(:basket){FactoryGirl.create(:basket, item_1_amount: 1, item_2_amount: 1, item_3_amount: 1)}

      it 'will have a subtotal of 62.90' do
        expect(basket.subtotal.round(2)).to eq(62.90)
      end

      it 'will have a total VAT of 3.50' do
        expect(basket.total_vat.round(2)).to eq(3.50)
      end

      it 'will have a flag discount of 0' do
        expect(basket.flag_discount).to eq(0)
      end

      it 'will have a total discount of 0' do
        expect(basket.total_discount.round(2)).to eq(0)
      end

      it 'will have a final total of 66.40' do
        expect(basket.total.round(2)).to eq(66.40)
      end
    end

    context 'when basket contains products 2,1,2' do
      subject(:basket){FactoryGirl.create(:basket, item_1_amount: 1, item_2_amount: 2)}

      it 'will have a subtotal of 87.8' do
        expect(basket.subtotal.round(2)).to eq(87.8)
      end

      it 'will have a total VAT of 3.39' do
        expect(basket.total_vat.round(2)).to eq(3.39)
      end

      it 'will have a flag discount of 0' do
        expect(basket.flag_discount).to eq(0)
      end

      it 'will have a total discount of 10.94' do
        expect(basket.total_discount.round(2)).to eq(10.94)
      end

      it 'will have a final total of 80.25' do
        expect(basket.total.round(2)).to eq(80.25)
      end
    end

    context 'when basket contains products 3,1,2,1' do
      subject(:basket){FactoryGirl.create(:basket, item_1_amount: 2, item_2_amount: 1, item_3_amount: 1)}

      it 'will have a subtotal of 82.90' do
        expect(basket.subtotal.round(2)).to eq(82.90)
      end

      it 'will have a total VAT of 3.50' do
        expect(basket.total_vat.round(2)).to eq(3.50)
      end

      it 'will have a flag discount of 5' do
        expect(basket.flag_discount).to eq(5)
      end

      it 'will have a total discount of 9.77' do
        expect(basket.total_discount.round(2)).to eq(9.77)
      end

      it 'will have a final total of 71.63' do
        expect(basket.total.round(2)).to eq(71.63)
      end
    end
  end
end
