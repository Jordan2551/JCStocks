class StocksController < ApplicationController

  def search
    if params[:stock]
      #Attemps to first set the stock to the one in the db
      @stock = Stock.find_stock_in_db(params[:stock])
      #If the stock is not found, look up the stock through the service and set it
      @stock ||= Stock.find_stock_by_service(params[:stock])
    end

    if @stock
      #render json: @stock
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end

end
