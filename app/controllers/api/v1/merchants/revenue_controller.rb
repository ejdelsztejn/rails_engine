class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    quantity = quantity_params[:quantity]
    render json: MerchantSerializer.new(Merchant.get_most_revenue(quantity))
  end

  private

  def quantity_params
    params.permit(:quantity)
  end
end
