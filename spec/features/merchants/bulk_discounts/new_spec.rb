require 'rails_helper'

RSpec.describe 'merchants bulk discount new' do
  it 'has a form to create a new bulk discount' do
    bulk_discount_test_seed_scenario_5
    visit new_merchant_bulk_discount_path(@merchant_1)

    fill_in('quantity_threshold', with: 5)
    fill_in('percentage_discount', with: '10%')
    click_button('Create Bulk Discount')

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to have_link('10% discount when buying 5 or more of a specific item')
  end
end