class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :bulk_discounts, through: :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  def self.incomplete_invoices
    Invoice.left_joins(:invoice_items)
           .where.not(invoice_items: { status: 2 })
           .distinct.order(:updated_at)
  end

  def total_merchant_invoice_revenue(merch_id)
    number_to_currency(self.items.where(merchant_id: merch_id).sum('invoice_items.quantity * invoice_items.unit_price') / 100.0)
  end

  def total_invoice_revenue
    number_to_currency(self.invoice_items.sum('invoice_items.quantity * invoice_items.unit_price') / 100.0)
  end

  def possible_revenue
    case_statement = 'min(invoice_items.quantity * invoice_items.unit_price *
                     (CASE WHEN bulk_discounts.quantity_threshold <= invoice_items.quantity
                           THEN (1 - bulk_discounts.percentage_discount)
                           ELSE 1
                           END)) as revenue'

    self.invoice_items.left_joins(:bulk_discounts)
                      .select("invoice_items.*, items.merchant_id, #{case_statement}")
                      .group(:id,'items.merchant_id')
  end

  def total_merchant_discount_invoice_revenue(merch)
    number_to_currency(Item.from(possible_revenue).where('merchant_id = ?', merch.id).sum('revenue') / 100)
  end

  def total_discount_invoice_revenue
    number_to_currency(Item.from(possible_revenue).sum('revenue') / 100)
  end
end
