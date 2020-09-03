class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    render json: MerchantSerializer.new(Merchant.get_most_revenue(query_params[:quantity]))
  end

  def revenue
    id = query_params[:id]
  end

  private

  def query_params
    params.permit(:id, :quantity)
  end
end
