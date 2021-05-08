class Coin < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true, uniqueness: { case_sensitive: false }
end
