class Coin < ApplicationRecord
  belongs_to :user
  self.primary_key = "symbol"
end
