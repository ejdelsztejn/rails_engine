class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_item(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      Item.find_by("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")
    else
      Item.find_by("items.#{attribute}::text ILIKE ?", "%#{value}%")
    end
  end
end
