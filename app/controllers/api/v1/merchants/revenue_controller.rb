class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    quantity = quantity_params[:quantity]
    require "pry"; binding.pry
    # create RevenueFacade
    # create Revenue PORO
    # create RevenueSerializer

    # within RevenueFacade, create find_merchants method
    # within the find_merchants method, call a get_merchants_revenue method with ActiveRecord query
    # using data from get_merchants_revenue, iterate through and create a new instance of a Revenue PORO
    # within this method, render json with the RevenueSerializer and a new instance of the RevenueFacade + find_merchants
  end

  private

  def quantity_params
    params.permit(:quantity)
  end
end
