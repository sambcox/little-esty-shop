class ChangeMerchantIdForBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bulk_discounts, :merchants, foreign_key: true
    add_reference :bulk_discounts, :merchant, foreign_key: true
  end
end
