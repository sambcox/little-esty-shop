require 'rails_helper'

RSpec.describe 'merchants bulk discount edit' do
  it 'has a prefilled form to update a new bulk discount' do
    bulk_discount_test_seed_scenario_5
    bulk_discount = @merchant_1.bulk_discounts.first
    visit edit_merchant_bulk_discount_path(@merchant_1, bulk_discount)

    expect(page).to have_field('bulk_discount[quantity_threshold]', with: bulk_discount.quantity_threshold)
    expect(page).to have_field('bulk_discount[percentage_discount]', with: bulk_discount.display_discount_percentage)

    fill_in('bulk_discount[quantity_threshold]', with: 5)
    fill_in('bulk_discount[percentage_discount]', with: '10%')
    click_button('Update Bulk discount')

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, bulk_discount))
    expect(page).to have_content('5')
    expect(page).to have_content('10%')
  end

  it 'will not update bulk discount if a number is not correct' do
    bulk_discount_test_seed_scenario_5
    bulk_discount = @merchant_1.bulk_discounts.first
    visit edit_merchant_bulk_discount_path(@merchant_1, bulk_discount)

    fill_in('bulk_discount[quantity_threshold]', with: 5)
    fill_in('bulk_discount[percentage_discount]', with: '1000%')
    click_button('Update Bulk discount')

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, bulk_discount))
    expect(page).to have_content('Not a valid discount')
  end
end