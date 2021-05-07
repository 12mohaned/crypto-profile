require 'http'
require 'json'
class HomesController < ApplicationController
    def home
        @Currencies = HTTP.get("https://api.binance.com/api/v3/ticker/price?").body.to_s
        @Currencies = JSON.parse(@Currencies)
        @Currencies_hash = {}
        @Currencies.each do |currency|
        @Currencies_hash[currency['symbol']] = currency['price']
        end
    end

    def create_stock
        stock = Stock.new
        stock.symbol = params[:symbol]
        stock.user = current_user
        stock.save
        # stock.user_id = current_user
        # p stock
        # stock.save
    end


end
