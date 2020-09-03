require 'rails_helper'

describe 'Merchants with Most Revenue Endpoint' do
  it 'can return a list of all items that belong to a given merchant' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = create(:item, unit_price: 10.00, merchant_id: merchant_1.id)
    item_2 = create(:item, unit_price: 15.00, merchant_id: merchant_2.id)
    item_3 = create(:item, unit_price: 5.00, merchant_id: merchant_3.id)

    5.times { create(:invoice, merchant_id: merchant_1.id) }
    5.times { create(:invoice, merchant_id: merchant_2.id) }
    5.times { create(:invoice, merchant_id: merchant_3.id) }

    merchant_1.invoices.each do |invoice|
      create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 100)
      create(:purchase)
    end
    merchant_2.invoices.each do |invoice|
      create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id, quantity: 10)
      create(:purchase)
    end
    merchant_3.invoices.each do |invoice|
      create(:invoice_item, invoice_id: invoice.id, item_id: item_3.id, quantity: 1000)
      create(:purchase)
    end

    get "/api/v1/merchants/most_revenue?quantity=3"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].first[:id]).to eq(merchant_3.id)
    expect(merchants[:data][1][:id]).to eq(merchant_3.id)
    expect(merchants[:data].last[:id]).to eq(merchant_2.id)
  end
end
