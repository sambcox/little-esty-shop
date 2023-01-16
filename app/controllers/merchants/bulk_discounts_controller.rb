module Merchants
  class BulkDiscountsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @bulk_discounts = @merchant.bulk_discounts
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @bulk_discount = BulkDiscount.find(params[:id])
    end

    def new
      @merchant = Merchant.find(params[:merchant_id])    
    end

    def create
      merchant = Merchant.find(params[:merchant_id])
      merchant.bulk_discounts.create!({percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold]})

      redirect_to merchant_bulk_discounts_path(merchant.id)
    end

    def destroy
      merchant = Merchant.find(params[:merchant_id])
      discount = BulkDiscount.find(params[:id])
      discount.destroy
      redirect_to merchant_bulk_discounts_path(merchant.id)
    end

    # private
    
    # def bulk_discount_params
    #   params.require(:bulk_discount).permit(:quantity_threshold, :percentage_discount)
    # end
  end
end