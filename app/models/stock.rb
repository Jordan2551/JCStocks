class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  #Functions needed to work with stocks. These are all static methods.

  #Looks into the db to try to find a stock by a ticker. This is so we don't have to look up the stock through the web service every time
  #The db and model association allows us to simply use where() because the model knows it is bound to the stocks db table
  def self.find_stock_in_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  #Look up a stock. If it does not exist, return nil
  def self.find_stock_by_service(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name

    #Create a new stock object if we pass the above test (stock not being nil)
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  #Gets the price for the relevant stock
  def price

    #If we are able to get the closing price then return it
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price

    #Otherwise, we try to get the opening price
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price

    #Otherwise, return unavailable
    'Unavailable'

  end

end
