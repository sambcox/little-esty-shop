require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'Relationships' do
    it { should belong_to :merchant }
  end

  describe 'Validations' do
    it { should validate_numericality_of :quantity_threshold }
    it { should validate_numericality_of(:percentage_discount).is_less_than(1) }
  end

  describe '#bulk_discounts_on_invoice' do
    it 'does not apply the discount if quantity does not meet for a single item' do
      bulk_discount_test_seed_scenario_1

      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1)).to eq([])
    end

    it 'only applies the discount to specific item quantity threshold is met on' do
      bulk_discount_test_seed_scenario_2

      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1)).to eq([@item_1])
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).first.item_discount).to eq(0.2)
    end

    it 'applies the correct discount to each item when an item qualifies for more than one discount' do
      bulk_discount_test_seed_scenario_3

      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort).to eq([@item_1, @item_2].sort)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.first.item_discount).to eq(0.2)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.second.item_discount).to eq(0.3)
    end

    it 'applies the correct discount to each item when both items qualify for both discounts' do
      bulk_discount_test_seed_scenario_4

      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort).to eq([@item_1, @item_2].sort)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.first.item_discount).to eq(0.2)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.second.item_discount).to eq(0.2)
    end
  end
end