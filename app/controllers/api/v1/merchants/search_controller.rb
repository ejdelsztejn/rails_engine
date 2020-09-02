class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute, value = query_params.to_h.first
    require "pry"; binding.pry
  end

  def query_params
    params.permit(:name, :created_at, :updated_at)
  end
end
