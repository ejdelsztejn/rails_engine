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
    merchant_id = create(:merchant).id
    item_params = { name: 'Baby Snake', description: 'A little baby snake friend', unit_price: 4.50, merchant_id: merchant_id }
    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/items', params: JSON.generate(item_params), headers: headers
    expect(response).to be_successful

    item = Item.first

    expect(item.name).to eq(item_params[:name])
  end
  it 'can update an existing item' do
    item = create(:item)
    initial_price = item.unit_price
    new_price = { unit_price: 10.00 }
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{item.id}", params: JSON.generate(new_price), headers: headers

    expect(response).to be_successful

    updated_item = Item.find(item.id)
    expect(updated_item.unit_price).to_not eq(initial_price)
    expect(updated_item.unit_price).to eq(new_price[:unit_price])
  end
  it 'can destroy an existing item' do
    item = create(:item)

    expect(Item.find(item.id)).to eq(item)

    delete "/api/v1/items/#{item.id}"
    expect(response).to be_successful

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
