require 'rails_helper'
require 'support/factory_girl'

describe Basket do
  describe '#scan(product_code)' do
    context 'when nothing scanned' do

      let(:basket) {create (:empty_basket)}
      it 'will have no items' do
        expect(basket.items.count).to equal(0)
      end
    end
  end
end
