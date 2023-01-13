require 'rails_helper'

RSpec.describe 'merchants bulk disocunts index' do
  it 'shows each bulk discount for the merchant' do
    bulk_discount_test_seed_scenario_5
    visit merchant_bulk_discounts_path(@merchant_1)

    expect(page).to have_content('20% discount when buying 10 or more of a specific item')
    expect(page).to have_content('30% discount when buying 15 or more of a specific item')

    visit merchant_bulk_discounts_path(@merchant_2)

    expect(page).to_not have_content('20% discount when buying 10 or more of a specific item')
    expect(page).to_not have_content('30% discount when buying 15 or more of a specific item')
  end
end