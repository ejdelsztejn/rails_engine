require 'rails_helper'

describe 'Items Endpoints' do
  it 'can return a list of all items' do
    create_list(:item, 5)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(5)
  end
  it 'can show details for a given item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end
end
