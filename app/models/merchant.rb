class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.find_merchant(attribute, value)
    Merchant.where("#{attribute} ILIKE ?", "%#{value}%")
  end
end
