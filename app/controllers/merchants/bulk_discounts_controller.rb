module Merchants
  class BulkDiscountsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
    end

    def new
      @merchant = Merchant.find(params[:merchant_id])
      @bulk_discount = BulkDiscount.new
    end

    def create
      merchant = Merchant.find(params[:merchant_id])

      bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)

      if bulk_discount.save
        redirect_to merchant_bulk_discounts_path(merchant)
      else
        flash[:notice] = 'Not a valid discount'
        redirect_to new_merchant_bulk_discount_path(merchant)
      end
    end

    private

    def bulk_discount_params
      params.require(:bulk_discount).permit(:quantity_threshold, :percentage_discount)
    end
  end
end