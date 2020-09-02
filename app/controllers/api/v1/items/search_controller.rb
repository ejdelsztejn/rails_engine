class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute, value = query_params.to_h.first
    render json: ItemSerializer.new(Item.find_item(attribute, value))
  end

  def index
    attribute, value = query_params.to_h.first
    render json: ItemSerializer.new(Item.find_all_items(attribute, value))
  end

  private

  def query_params
    params.permit(:name, :unit_price, :description, :created_at, :updated_at, :merchant_id)
  end
end
