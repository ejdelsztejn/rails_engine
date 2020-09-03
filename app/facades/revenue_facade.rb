class RevenueFacade
  def find_merchants(quantity)
    merchant_revenue = get_merchants_revenue(quantity)
    merchant_revenue.each do |revenue|
      Revenue.new(revenue)
    end
  end

  def get_merchants_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .joins(invoices: [:invoice_items, :purchases])
    .where("purchases.result='success' AND invoices.status='shipped'")
    .group(:id)
    .order("total_revenue desc")
    .limit(quantity)
  end
end
