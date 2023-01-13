class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :quantity_threshold
      t.decimal :percentage_discount, precision: 5, scale: 4
      t.references :merchants, foreign_key: :true
      t.timestamps
    end
  end
end
