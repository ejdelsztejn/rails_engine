class RevenueFacade
  def merchant_revenue(merchant_id)
    merchant = Merchant.find_by(id: merchant_id)
    revenue = merchant.get_revenue
    Revenue.new(revenue)
  end
end

class Revenue
  attr_reader :id, :revenue

  def initialize(revenue)
    @id = 'null'
    @revenue = revenue
  end
end
