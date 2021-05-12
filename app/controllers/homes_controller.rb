require 'http'
require 'json'
class HomesController < ApplicationController
    def home
        @featured_index = 0
        @price_change   = Array.new
        @featured_coins = Hash.new
        @featured_coins["Bitcoin"]  =  convert_json("BTCUSDT")
        @featured_coins["Ethereum"]  =  convert_json("ETHUSDT")
        @featured_coins["Dash"] = convert_json("DASHUSDT")
        @featured_coins["Doge"] = convert_json("DOGEUSDT")
        @featured_coins["XRP"] =  convert_json("XRPUSDT")  
        calculate_avg_price(@featured_coins, 5)
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
    
    #Calculate the change in price and determine whether featured prices increased or decreased
    def calculate_avg_price(featured_coins, num)
        @change_rate
        @prices_change = Array.new
        @featured_coins.each do |name, symbol|
        @stocks = HTTP.get("https://api.binance.com/api/v3/ticker/24hr?symbol=" + symbol['symbol']).body.to_s
        @stocks = JSON.parse(@stocks)
        if @stocks['priceChangePercent'].to_f > 0
            @change_rate = true 
        else
            @change_rate = false
        end
        @prices_change.push(@change_rate)
    end
    end

end
