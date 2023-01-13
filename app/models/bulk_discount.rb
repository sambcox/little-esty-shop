class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_numericality_of :quantity_threshold
  validates_numericality_of :percentage_discount, less_than: 1
  before_validation :numericise_percentage_discount

  def numericise_percentage_discount
    self.percentage_discount = percentage_discount.to_f / 100 if percentage_discount.to_i > 1
  end

  def display_discount_percentage
    "#{(percentage_discount*100).to_i}%"
  end
end