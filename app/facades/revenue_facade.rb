class RevenueFacade
  def find_revenue(merchant)
    merchant.get_revenue(merchant.id)
  end
end
