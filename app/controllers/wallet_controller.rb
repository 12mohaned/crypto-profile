require 'http'
require 'json'
class WalletController < ApplicationController
    def Mywallet 
        @portoflio = Array.new
        @user_coins = Coin.where(user: current_user)
        @user_coins.each do |stock|
        @stocks = HTTP.get("https://api.binance.com/api/v3/ticker/24hr?symbol=" + stock.symbol).body.to_s
        @stocks = JSON.parse(@stocks)
        @portoflio.push(@stocks)
        end
        end

 
end
