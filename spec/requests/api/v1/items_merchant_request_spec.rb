require 'rails_helper'

describe 'Items Merchant Endpoint' do
  it 'can return the merchant of a given item' do
    merchant = create(:merchant)
    item = Item.create(name: "Baby Kangaroo", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(item_merchant[:data]).to have_key(:id)
    expect(item_merchant[:data]).to have_key(:type)
    expect(item_merchant[:data]).to have_key(:attributes)
    expect(item_merchant[:data][:type]).to eq('merchant')
    expect(item_merchant[:data][:attributes][:name]).to eq('Lizard Palace')
  end
end
