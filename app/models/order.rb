class Order < ActiveRecord::Base
  attr_accessible :customer_id, :status

  has_many :order_items, dependent: :destroy

  def total
    order_items.map(&:subtotal).inject(0, &:+)
  end
end
