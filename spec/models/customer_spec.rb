require 'rails_helper'

describe Customer, type: :model do
  describe 'validations' do
    it { should_validate_presence_of :first_name }
    it { should_validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end
end
