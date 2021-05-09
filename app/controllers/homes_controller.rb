require 'http'
require 'json'
class HomesController < ApplicationController
    def home
        @featured_coins = Hash.new
        @featured_coins["Bitcoin"]  =  convert_json("BTCUSDT")
        @featured_coins["Ethereum"]  =  convert_json("ETHUSDT")
        @featured_coins["Dash"] = convert_json("DASHUSDT")
        @featured_coins["Doge"] = convert_json("DOGEUSDT")
        @featured_coins["XRP"] =  convert_json("XRPUSDT")  

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

    def convert_json(symbol)
        @currency = HTTP.get("https://api.binance.com/api/v3/ticker/price?symbol="+symbol).body.to_s
        @currency = JSON.parse(@currency)
        return @currency
    end

end
