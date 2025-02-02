require 'rails_helper'

RSpec.describe 'The Merchant Dashboard' do
  it 'Contains the name of the merchant' do
    merchant = Merchant.create!(name: 'Bobby')

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end

  it 'contains a link to merchant item index and merchant invoices index' do
    merchant = Merchant.create!(name: 'Bobby')

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link('Items', href: "/merchants/#{merchant.id}/items")
    expect(page).to have_link('Invoices', href: "/merchants/#{merchant.id}/invoices")
  end

  it 'contains a list of the top five customers based on successful transactions' do
    visit merchant_dashboard_path(2)

    expect(page).to have_content('Ramona Reynolds - 6 Purchases Joey Ondricka - 5 Purchases Logan Kris - 3 Purchases Cecelia Osinski - 1 Purchases Mariah Toy - 1 Purchases')
  end

  describe 'items ready to ship' do
    it 'has a list of items ready to ship including quantity' do
      visit merchant_dashboard_path(1)

      expect(page).to have_content('Items Ready to Ship')
      expect(page).to have_content('Item Quidem Suscipit - Invoice #76 - Wednesday, March 7, 2012 Item Rerum Est - Invoice #3 - Saturday, March 10, 2012 Item Autem Minima - Invoice #38 - Saturday, March 10, 2012 Item Ea Voluptatum - Invoice #38 - Saturday, March 10, 2012 Item Quidem Suscipit - Invoice #2 - Monday, March 12, 2012 Item Ea Voluptatum - Invoice #75 - Monday, March 12, 2012 Item Nemo Facere - Invoice #75 - Monday, March 12, 2012 Item Expedita Aliquam - Invoice #75 - Monday, March 12, 2012 Item Expedita Fuga - Invoice #75 - Monday, March 12, 2012 Item Quo Magnam - Invoice #75 - Monday, March 12, 2012 Item Et Cumque - Invoice #40 - Wednesday, March 14, 2012 Item Voluptatem Sint - Invoice #40 - Wednesday, March 14, 2012 Item Qui Esse - Invoice #1 - Sunday, March 25, 2012 Item Ea Voluptatum - Invoice #1 - Sunday, March 25, 2012 Item Nemo Facere - Invoice #1 - Sunday, March 25, 2012 Item Provident At - Invoice #1 - Sunday, March 25, 2012')
      expect(page).to have_link('1', href: '/merchants/1/invoices/1')
      expect(page).to have_link('3', href: '/merchants/1/invoices/3')
      expect(page).to have_link('38', href: '/merchants/1/invoices/38')
      expect(page).to have_link('2', href: '/merchants/1/invoices/2')
    end

    it 'the list is ordered by oldest to newest and shows date invoice created' do
      visit merchant_dashboard_path(1)

      expect(Item.find(10).name).to appear_before(Item.find(15).name)
      expect(Item.find(15).name).to appear_before(Item.find(2).name)
      expect(Item.find(2).name).to appear_before(Item.find(3).name)
      expect(Item.find(3).name).to appear_before(Item.find(4).name)
    end

    it 'contains a link to view all merchant specific discounts' do
      bulk_discount_test_seed_scenario_5
      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_link('Bulk Discounts', href: merchant_bulk_discounts_path(@merchant_1))
    end
  end
end
