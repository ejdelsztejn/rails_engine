require 'rails_helper'

describe 'Merchants Multiple Finder Endpoint' do
  it 'can return all records that matches a set of criteria' do
    create(:merchant)
    create(:merchant)
    create(:merchant)
    create(:merchant)
    create(:merchant, name: 'Hamster World')

    name = "name"
    name_query = "lizard"

    get "/api/v1/merchants/find_all?#{name}=#{name_query}"

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants_by_name = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_by_name[:data].count).to eq(4)
    merchants_by_name[:data].each do |datum|
      expect(datum[:type]).to eq('merchant')
      expect(datum[:attributes][:name]).to eq('Lizard Palace')
      expect(datum[:attributes][:name]).to_not eq('Hamster World')
    end
  end
end
