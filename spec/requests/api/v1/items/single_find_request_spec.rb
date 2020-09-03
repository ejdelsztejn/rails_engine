require 'rails_helper'

describe 'Items Single Finder Endpoint' do
  it 'can return a single record that matches a set of criteria' do
    merchant = create(:merchant)
    Item.create(name: "Kangaroo", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)
    Item.create(name: "Sloth", description: 'A little friend', unit_price: 1.50, merchant_id: merchant.id)
    Item.create(name: "Crocodile", description: 'A little friend', unit_price: 88.0, merchant_id: merchant.id)

    name = "name"
    name_query = "OTH"

    get "/api/v1/items/find?#{name}=#{name_query}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_name = JSON.parse(response.body, symbolize_names: true)

    # expect(item_name[:data][:type]).to eq('item')
    expect(item_name[:data][:attributes][:name]).to eq('Sloth')

    unit_price = 'unit_price'
    unit_price_query = 8

    get "/api/v1/items/find?#{unit_price}=#{unit_price_query}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_price = JSON.parse(response.body, symbolize_names: true)
    expect(item_price[:data][:type]).to eq('item')
    expect(item_price[:data][:attributes][:unit_price]).to eq(88)

    created_at = 'created_at'
    date = Item.last.created_at

    get "/api/v1/items/find?#{created_at}=#{date}"

    expect(response).to be_successful

    item_date = JSON.parse(response.body, symbolize_names: true)

  #  expect(item_date[:data][:type]).to eq('item')
  end
end
