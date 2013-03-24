class Product < ActiveRecord::Base
  attr_accessible :title, :price, :description, :image_url, :stock

  has_many :order_items

  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 0 }

  def price=(value)
    value.delete!("$")
    super
  end
end
