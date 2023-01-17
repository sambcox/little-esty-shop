require 'rails_helper'

RSpec.describe 'merchants bulk discount new' do
  it 'has a form to create a new bulk discount' do
    bulk_discount_test_seed_scenario_5
    visit new_merchant_bulk_discount_path(@merchant_1)

    fill_in('bulk_discount[quantity_threshold]', with: 5)
    fill_in('bulk_discount[percentage_discount]', with: '10%')
    click_button('Create Bulk discount')

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to have_link('10% discount when buying 5 or more of a specific item')
  end

  it 'will not create bulk discount if a number is not correct' do
    bulk_discount_test_seed_scenario_5
    visit new_merchant_bulk_discount_path(@merchant_1)

    fill_in('bulk_discount[quantity_threshold]', with: 5)
    fill_in('bulk_discount[percentage_discount]', with: '1000%')
    click_button('Create Bulk discount')

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
    expect(page).to have_content('Not a valid discount')
  end

  it 'will not create bulk discount if a number is not correct' do
    bulk_discount_test_seed_scenario_5
    visit new_merchant_bulk_discount_path(@merchant_1)

    fill_in('bulk_discount[quantity_threshold]', with: 20)
    fill_in('bulk_discount[percentage_discount]', with: '10%')
    click_button('Create Bulk discount')

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
    expect(page).to have_content('Not a valid discount')
  end
end