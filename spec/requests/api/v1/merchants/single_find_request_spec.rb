require 'rails_helper'

describe 'Merchants Single Finder Endpoint' do
  it 'can return a single record that matches a set of criteria' do
    merchant = create(:merchant)

    attribute = "name"
    query = "zArD p"

    get "/api/v1/merchants/find?#{attribute}=#{query}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to eq('Lizard Palace')
  end
end
