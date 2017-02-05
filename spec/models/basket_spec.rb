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
        expect(subject.product_code).to eq(seat.product_code)
      end

      it 'will have an item with name of a seat' do
        expect(subject.name).to eq(seat.name)
      end

      it 'will have an item with the price for a seat' do
        expect(subject.price).to eq(seat.price)
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

  describe '#subtotal' do
    context 'when basket contains products 1,2,3' do
      it 'will product a subtotal of 62.90' do
        expect(basket.subtotal.round(2)).to eq(62.90)
      end
    end
  end
end
