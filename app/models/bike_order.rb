class BikeOrder < ApplicationRecord
  validates_with BikeOrderValidator

  attr_accessor :warnings
  
  belongs_to :user
  has_many :bike_order_items, dependent: :delete_all
  
  accepts_nested_attributes_for :bike_order_items, allow_destroy: true

  def calculate_bike_order_prices!
    bike_order_items.each{|boi| boi.calculate_price }
  end
end
