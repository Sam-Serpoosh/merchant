require File.dirname(__FILE__) + '/../spec_helper'

describe OrderItem do
  let(:order_item) {
    OrderItem.new(product_id: 1, order_id: 1, quantity: 1)
  }

  context "#validation" do
    it "is not valid withouth order id" do
      order_item.order_id = nil
      order_item.should_not be_valid
    end

    it "is not valid without product id" do
      order_item.product_id = nil
      order_item.should_not be_valid
    end
  end
end
