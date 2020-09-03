class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  scope :single_by_date, -> (attribute, value) {find_by("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")}
  scope :single_by_attribute, -> (attribute, value) {find_by("merchants.#{attribute}::text ILIKE ?", "%#{value}%")}
  scope :multi_by_date, -> (attribute, value) {where("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{value}%")}
  scope :multi_by_attribute, -> (attribute, value) {where("merchants.#{attribute}::text ILIKE ?", "%#{value}%")}

  def self.find_merchant(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      single_by_date(attribute, value)
    else
      single_by_attribute(attribute, value)
    end
  end

  def self.find_all_merchants(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      multi_by_date(attribute, value)
    else
      multi_by_attribute(attribute, value)
    end
  end

  def self.get_most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .joins(invoices: [:invoice_items, :purchases])
    .where("purchases.result='success' and invoices.status='shipped'")
    .group(:id)
    .order("total_revenue desc")
    .limit(quantity)
  end

  def get_revenue
    invoice_items.joins(:invoice, :purchases)
    .where("purchases.result='success' and invoices.status='shipped'")
    .sum("unit_price * quantity")
  end
end
