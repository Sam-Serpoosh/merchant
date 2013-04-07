class Order < ActiveRecord::Base
  attr_accessible :user, :status

  has_many :order_items, dependent: :destroy
  belongs_to :user, foreign_key: :customer_id
  belongs_to :address

  def total
    order_items.map(&:subtotal).inject(0, &:+)
  end
end
