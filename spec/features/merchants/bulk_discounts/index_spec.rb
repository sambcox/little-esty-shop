require 'rails_helper'

RSpec.describe 'merchants bulk discounts index' do
  it 'shows each bulk discount for the merchant' do
    bulk_discount_test_seed_scenario_5
    visit merchant_bulk_discounts_path(@merchant_1)

    expect(page).to have_link('20% discount when buying 10 or more of a specific item', href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    expect(page).to have_link('30% discount when buying 15 or more of a specific item', href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_2))

    visit merchant_bulk_discounts_path(@merchant_2)

    expect(page).to_not have_content('20% discount when buying 10 or more of a specific item')
    expect(page).to_not have_content('30% discount when buying 15 or more of a specific item')
  end

  it 'has a link to create a new bulk discount' do
    bulk_discount_test_seed_scenario_5
    visit merchant_bulk_discounts_path(@merchant_1)

    click_button 'Create a new bulk discount'
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
  end

  it 'has a button to delete each bulk discount' do
    bulk_discount_test_seed_scenario_5
    visit merchant_bulk_discounts_path(@merchant_1)
    bulk_discount = @merchant_1.bulk_discounts.first

    within("#bulk_discount_#{bulk_discount.id}") do
      click_button 'Delete Bulk Discount'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to have_content(@merchant_1.bulk_discounts.last.quantity_threshold)
    expect(page).to_not have_content(bulk_discount.quantity_threshold)
    reload bulk_discount
    expect(bulk_discount.exists?).to eq false
  end
end