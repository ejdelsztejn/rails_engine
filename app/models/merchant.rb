class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.find_merchant(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      Merchant.find_by("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")
    else
      Merchant.find_by("merchants.#{attribute} ILIKE ?", "%#{value}%")
    end
  end

  def self.find_all_merchants(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      Merchant.where("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")
    else
      Merchant.where("merchants.#{attribute}::text ILIKE ?", "%#{value}%")
    end
  end
end
