require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  context "#deleting" do
    it "also deletes containing order items" do
      order = Order.create!
      order.order_items.build(product_id: 1, quantity: 1)
      order.order_items.build(product_id: 2, quantity: 1)
      order.save!
      order.destroy
      Order.count.should == 0
      OrderItem.count.should == 0
    end
  end

  context "#total" do
    before do
      product = Product.create!(price: "10", stock: 10)
      @order = Order.create!
      @order.order_items.build(product_id: product.id, quantity: 3)
      @order.save!
    end

    it "calculates order total price" do
      @order.total.should == 30
    end
  end
end
