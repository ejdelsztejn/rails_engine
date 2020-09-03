class RevenueFacade
  def find_merchants(quantity)
    merchant_revenue = get_merchants_revenue(quantity)
    merchant_revenue.each do |revenue|
      Revenue.new(revenue)
    end
  end
end
