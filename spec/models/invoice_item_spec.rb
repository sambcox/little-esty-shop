require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'Relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:transactions).through(:invoice) }
    it { should validate_numericality_of :quantity }
    it { should validate_numericality_of :unit_price }
  end

  it 'converts unit price to dollars' do
    expect(InvoiceItem.first.unit_price_to_dollars).to eq('$136.35')
  end

  it 'returns the bulk discount for this item' do
    bulk_discount_test_seed_scenario_5

    expect(@invoice_1.invoice_items.first.bulk_discount).to eq(@merchant_1.bulk_discounts.first)
    expect(@invoice_1.invoice_items.second.bulk_discount).to eq(@merchant_1.bulk_discounts.second)
    expect(@invoice_1.invoice_items.third.bulk_discount).to eq(nil)
  end
end
