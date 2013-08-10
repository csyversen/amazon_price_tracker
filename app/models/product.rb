class Product < ActiveRecord::Base

  has_many :prices
  has_and_belongs_to_many :users
  
  scope :current_price, -> { prices.last }
  scope :lowest_price, -> { prices.minimum("price") }

end
