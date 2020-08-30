require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should_validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end
end
