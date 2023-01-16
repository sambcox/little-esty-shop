require 'rails_helper'

RSpec.describe Invoice do
  describe 'Relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'Class Methods' do
    it 'returns the invoices with not shipped items in order by oldest' do
      expect(Invoice.incomplete_invoices).to be_a ActiveRecord::Relation
      expect(Invoice.incomplete_invoices.count).to eq 70
      expect(Invoice.incomplete_invoices.first).to eq(Invoice.find(10))
    end
  end

  describe 'Instance Methods' do
    it 'returns the total revenue for a specific invoice' do
      expect(Invoice.find(31).total_invoice_revenue).to eq('$28,499.29')
    end

    it 'returns the total revenue for an invoice for one merchant' do
      InvoiceItem.create!({item_id: 4, invoice_id: 31, quantity: 40, unit_price: Item.find(4).unit_price})

      expect(Invoice.find(31).total_merchant_invoice_revenue(8)).to eq('$28,499.29')
    end

    it 'returns the total revenue for a specific merchants invoice after discount' do
      bulk_discount_test_seed_scenario_5

      expect(@invoice_1.total_merchant_discount_invoice_revenue(@merchant_1)).to eq('$16,500.00')

      @new_item = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: 20000, description: Faker::TvShows::Community.quotes })
      InvoiceItem.create!({ invoice_id: @invoice_1.id, item_id: @new_item.id, unit_price: @new_item.unit_price, quantity: 5})

      expect(@invoice_1.total_merchant_discount_invoice_revenue(@merchant_1)).to eq('$17,500.00')
    end

    it 'returns the total revenue for a total invoice after discount' do
      bulk_discount_test_seed_scenario_5

      expect(@invoice_1.total_discount_invoice_revenue).to eq('$21,000.00')
    end
  end
end
