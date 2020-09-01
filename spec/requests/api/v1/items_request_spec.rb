require 'rails_helper'

describe 'Items Endpoints' do
  it 'can return a list of all items' do
    create_list(:item, 5)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(5)
    expect(items[:data].first).to have_key(:id)
    expect(items[:data].first).to have_key(:type)
    expect(items[:data].first).to have_key(:attributes)
  end
  it 'can show details for a given item' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:id]).to eq(id)
  end
  it 'can create a new item' do
    merchant = Merchant.create(name: 'The Snake Charmer')
    item_params = { name: 'Baby Snake', description: 'A little baby snake friend', unit_price: 4.50, merchant_id: merchant.id }

    post '/api/v1/items', params: { item: item_params }
    expect(response).to be_successful

    item = Item.first

    expect(item.name).to eq(item_params[:name])
  end
end
