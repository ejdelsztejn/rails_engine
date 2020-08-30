require 'rails_helper'

describe Invoice, type: :model do
  describe 'validations' do
    it { should_validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should belong_to :customer }
  end
end