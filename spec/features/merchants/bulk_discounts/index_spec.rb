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
    bulk_discount_id = @merchant_1.bulk_discounts.first.id

    within("#bulk_discount_#{bulk_discount_id}") do
      click_button 'Delete Bulk Discount'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to have_content(@merchant_1.bulk_discounts.last.quantity_threshold)
    expect(page).to_not have_selector("#bulk_discount_#{bulk_discount_id}")

    expect(BulkDiscount.exists?(bulk_discount_id)).to eq false
  end

  it 'shows upcoming holidays' do
    bulk_discount_test_seed_scenario_5
    visit merchant_bulk_discounts_path(@merchant_1)
    get_url = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    holidays = JSON.parse(get_url.body, symbolize_names: true)

    within '#upcoming_holidays' do
      expect(page).to have_content(holidays.first[:localName])
      expect(page).to have_content(holidays.second[:localName])
      expect(page).to have_content(holidays.third[:localName])
      expect(page).to have_content(holidays.first[:date])
      expect(page).to have_content(holidays.second[:date])
      expect(page).to have_content(holidays.third[:date])
    end
  end
end