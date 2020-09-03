require 'rails_helper'

RSpec.describe 'RevenueFacade' do
  it 'find_merchants' do
    @revenue = RevenueFacade.new
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = create(:item, unit_price: 10.00, merchant: merchant_1)
    item_2 = create(:item, unit_price: 15.00, merchant: merchant_2)
    item_3 = create(:item, unit_price: 5.00, merchant: merchant_3)

    5.times { create(:invoice, merchant: merchant_1) }
    5.times { create(:invoice, merchant: merchant_2) }
    5.times { create(:invoice, merchant: merchant_3) }

    merchant_1.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_1, quantity: 100)
      create(:purchase, invoice: invoice)
    end
    merchant_2.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_2, quantity: 10)
      create(:purchase, invoice: invoice)
    end
    merchant_3.invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, item: item_3, quantity: 1000)
      create(:purchase, invoice: invoice)
    end

    revenue = @revenue.find_revenue(merchant_1.id)
    expect(merchants.class).to eq(Array)
  end
end
