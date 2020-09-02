class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.find_merchant(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      require "pry"; binding.pry
      Merchant.find_by("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")
    else
      Merchant.find_by("#{attribute} ILIKE ?", "%#{value}%")
    end
  end
end
