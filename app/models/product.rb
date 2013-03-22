class Product < ActiveRecord::Base
  attr_accessible :title, :price, :description, :image_url

  validates :price, numericality: true

  def price=(value)
    value.delete!("$")
    super
  end
end
