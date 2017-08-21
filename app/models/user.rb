class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def can_add_stock?(ticker_symbol)
    #You can only add a stock if you're under the stock limit AND the stock you want to track is not already being tracked by the same user
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end

  def under_stock_limit?
    #This references the specific user (the db record) so don't be surprised
    (user_stocks.count <= 10)
  end

  def stock_already_added?(ticker_symbol)
     stock = Stock.find_by_ticker(ticker_symbol)
     return false unless stock
     user_stocks.where(stock_id: stock.id).exists?
  end

end
