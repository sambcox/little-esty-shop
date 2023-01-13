require 'rails_helper'

RSpec.describe 'merchants bulk discount show' do
  it 'shows the bulk discount information' do
    bulk_discount_test_seed_scenario_5
    bulk_discount = @merchant_1.bulk_discounts.first
    visit merchant_bulk_discount_path(@merchant_1, bulk_discount)

    expect(page).to have_content(bulk_discount.percentage_discount*100)
    expect(page).to have_content(bulk_discount.quantity_threshold)
    expect(page).to_not have_content(@merchant_1.bulk_discounts.second.percentage_discount*100)
    expect(page).to_not have_content(@merchant_1.bulk_discounts.second.quantity_threshold)
  end
end