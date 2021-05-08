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
        coin = Coin.new
        coin.symbol = params[:symbol]
        coin.user = current_user
        coin.save
    end
end
