require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'Relationships' do
    it { should belong_to :merchant }
  end

  describe 'Validations' do
    it { should validate_numericality_of :quantity_threshold }
    it { should validate_numericality_of :percentage_discount }
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

    it 'for items on the same invoice, only applies discounts to items that apply to a merchant that has a bulk discount' do
      bulk_discount_test_seed_scenario_5

      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort).to eq([@item_1, @item_2].sort)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.first.item_discount).to eq(0.2)
      expect(@merchant_1.bulk_discounts_on_invoice(@invoice_1).sort.second.item_discount).to eq(0.3)
      expect(@merchant_2.bulk_discounts_on_invoice(@invoice_1)).to eq([])
    end
  end

  describe '#display_discount_percentage' do
    it 'returns the discount formatted as a percentage' do
      bulk_discount_test_seed_scenario_5

      expect(@bulk_discount_1.display_discount_percentage).to eq('20%')
    end
  end

  describe '#numericize_discount_percentage' do
    it 'reformats the discount if need be' do
      bulk_discount_test_seed_scenario_5

      bulk_discount = @merchant_1.bulk_discounts.create!({quantity_threshold: 2, percentage_discount: 2})
      expect(bulk_discount.percentage_discount).to eq 0.02
    end
  end
end