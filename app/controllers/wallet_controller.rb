require 'http'
require 'json'
class WalletController < ApplicationController
    def Mywallet 
        @portoflio = Stock.where(user: current_user)
        @portoflio.each do |stock|
        @stocks = HTTP.get("https://api.binance.com/api/v3/ticker/24hr?symbol=" + stock.symbol).body.to_s
        @stocks = JSON.parse(@stocks)
        p @stocks
        end
        end

 
end
