class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_numericality_of :quantity_threshold
  validates_numericality_of :percentage_discount, less_than: 1
end