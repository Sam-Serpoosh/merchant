require 'spec_helper'

describe OrderItemsController do
  describe "creating" do
    it "increases the quantity of order item for same product" do
      product = Product.create!(price: "10", stock: 5)
      2.times do
        post :create, product_id: product.id
      end
      Order.first.order_items[0].quantity.should == 2
    end
  end
end
