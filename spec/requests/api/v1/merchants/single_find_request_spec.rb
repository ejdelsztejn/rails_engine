require 'rails_helper'

describe 'Merchants Single Finder Endpoint' do
  xit 'can return a single record that matches a set of criteria' do
    create(:merchant)

    attribute = "name"
    query = "zArD p"

    get "/api/v1/merchants/find?#{attribute}=#{query}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to eq('Lizard Palace')

    created_at = 'created_at'
    date = Merchant.last.created_at

    get "/api/v1/merchants/find?#{created_at}=#{date}"

    expect(response).to be_successful

    merchant_date = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
    expect(merchant_date[:data][:type]).to eq('merchant')
  end
end
