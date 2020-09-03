FactoryBot.define do
  factory :invoice_item do
    quantity { 10 }
    unit_price { 5.00 }
    invoice
    item
  end
end
