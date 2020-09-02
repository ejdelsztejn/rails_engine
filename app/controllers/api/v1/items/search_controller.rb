class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute, value = query_params.to_h.first
    @result = Item.where("#{attribute} LIKE ?", "%#{value}%")
    require "pry"; binding.pry
  end

  private

  def query_params
    params.permit(:name, :unit_price, :description, :created_at, :updated_at, :merchant_id)
  end
end
