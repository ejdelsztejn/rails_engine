require 'rails_helper'

RSpec.describe 'RevenueFacade' do
  before :each do
    @revenue = RevenueFacade.new
  end

  it 'find_merchants' do
    merchants = @revenue.find_merchants(3)
    expect(merchants.class).to eq(Array)
  end
end
