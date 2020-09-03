require 'rails_helper'

describe 'Revenue for a Given Merchant Endpoint' do
  it 'can return the total revenue given merchant' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = create(:item, unit_price: 10.00, merchant: merchant_1)
    item_2 = create(:item, unit_price: 15.00, merchant: merchant_2)
    item_3 = create(:item, unit_price: 5.00, merchant: merchant_3)

    5.times { create(:invoice, merchant: merchant_1) }
    5.times { create(:invoice, merchant: merchant_2) }
    5.times { create(:invoice, merchant: merchant_3) }

    merchant_1.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_1, quantity: 100)
      create(:purchase, invoice: invoice)
    end
    merchant_2.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_2, quantity: 10)
      create(:purchase, invoice: invoice)
    end
    merchant_3.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_3, quantity: 1000)
      create(:purchase, invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant_2.id}/revenue"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    total_revenue = JSON.parse(response.body, symbolize_names: true)

    expect(total_revenue[:data][:attributes][:revenue]).to eq(250)
  end
end
