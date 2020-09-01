FactoryBot.define do
  factory :item do
    name { "Baby Lizard" }
    description { "A cute baby lizard!" }
    unit_price { 3.50 }
    merchant
  end
end
