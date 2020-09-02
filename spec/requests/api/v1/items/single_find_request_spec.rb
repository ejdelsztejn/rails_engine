require 'rails_helper'

describe 'Items Single Finder Endpoint' do
  it 'can return a single record that matches a set of criteria' do
    merchant = create(:merchant)
    item = Item.create(name: "Kangaroo", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)
    item = Item.create(name: "Sloth", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)
    item = Item.create(name: "Crocodile", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)

    attribute = "name"
    query = "OTH"

    get "/api/v1/items/find?#{attribute}=#{query}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    
    expect(item[:data][:type]).to eq('item')
    expect(item[:data][:attributes][:name]).to eq('Sloth')
  end
end
