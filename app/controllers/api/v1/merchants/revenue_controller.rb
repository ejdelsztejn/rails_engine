class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    render json: MerchantSerializer.new(Merchant.get_most_revenue(query_params[:quantity]))
  end

  def revenue
    render json: RevenueSerializer.new(RevenueFacade.new.merchant_revenue(query_params[:id]))
  end

  private

  def query_params
    params.permit(:id, :quantity)
  end
end
