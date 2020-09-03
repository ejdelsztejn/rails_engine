class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :single_by_date, -> (attribute, value) {find_by("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")}
  scope :single_by_attribute, -> (attribute, value) {find_by("items.#{attribute}::text ILIKE ?", "%#{value}%")}
  scope :multi_by_date, -> (attribute, value) {where("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")}
  scope :multi_by_attribute, -> (attribute, value) {where("items.#{attribute}::text ILIKE ?", "%#{value}%")}

  def self.find_item(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      single_by_date(attribute, value)
    else
      single_by_attribute(attribute, value)
    end
  end

  def self.find_all_items(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      multi_by_date(attribute, value)
    else
      multi_by_attribute(attribute, value)
    end
  end
end
