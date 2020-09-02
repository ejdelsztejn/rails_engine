class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute, value = query_params.to_h.first
    render json: MerchantSerializer.new(Merchant.find_merchant(attribute, value))
  end

  def query_params
    params.permit(:name, :created_at, :updated_at)
  end
end
