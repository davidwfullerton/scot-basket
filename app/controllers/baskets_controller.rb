class BasketsController < ApplicationController
  include ActionView::Helpers::NumberHelper


  def new
    @basket = Basket.new

    @sub = number_to_currency(@basket.subtotal + @basket.total_vat, unit: '£')
  end

  def create
    @basket = Basket.create
    @basket.scan(params[:item].to_i)
    redirect_to action: 'edit', id: @basket.id
  end

  def edit
    @basket = Basket.find(params[:id])
    @sub = number_to_currency(@basket.subtotal + @basket.total_vat, unit: '£')
  end

  def update
    @basket = Basket.find(params[:id])
    @basket.scan(params[:item].to_i)
    redirect_to :back
  end
end
