require 'rails_helper'

describe 'Merchants Items Endpoint' do
  it 'can return a list of all items that belong to a given merchant' do
    merchant = create(:merchant)
    animal = ['Dugong', 'Fossa', 'Pink Fairy Armadillo', 'Lamprey', 'Star-Nosed Mole']
    5.times do
      Item.create(name: "Baby #{animal.sample}", description: 'A little friend', unit_price: rand(1..5).to_f, merchant_id: merchant.id)
    end

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_items[:data].count).to eq(5)
    expect(merchant_items[:data].first).to have_key(:id)
    expect(merchant_items[:data].first).to have_key(:type)
    expect(merchant_items[:data].first).to have_key(:attributes)
    expect(merchant_items[:data].first[:attributes][:description]).to eq('A little friend')
  end
end
