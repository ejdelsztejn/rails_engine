FactoryBot.define do
  factory :purchase do
    invoice
    credit_card_number { '4580251236515201' }
    result { 'success' }
  end
end
