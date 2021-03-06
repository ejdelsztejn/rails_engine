require 'rails_helper'

describe 'Merchants Endpoints' do
  it 'can return a list of all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(5)
    expect(merchants[:data].first).to have_key(:id)
    expect(merchants[:data].first).to have_key(:type)
    expect(merchants[:data].first).to have_key(:attributes)
  end
  it 'can show details for a given merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:id]).to eq(id)
  end
  it 'can create a new merchant' do
    merchant_params = { name: 'Bird and Reptile Emporium' }
    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/merchants', params: JSON.generate(merchant_params), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = Merchant.first

    expect(merchant.name).to eq(merchant_params[:name])
  end
  it 'can update an existing merchant' do
    merchant = create(:merchant)
    initial_name = merchant.name
    new_name = { name: 'Bird and Reptile Emporium' }
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/merchants/#{merchant.id}", params: JSON.generate(new_name), headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    updated_merchant = Merchant.find(merchant.id)
    expect(updated_merchant.name).to_not eq(initial_name)
    expect(updated_merchant.name).to eq(new_name[:name])
  end
  it 'can destroy an existing merchant' do
    merchant = create(:merchant)

    expect(Merchant.find(merchant.id)).to eq(merchant)

    delete "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
