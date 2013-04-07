require 'spec_helper'

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

  context "#association" do
    it "belongs to user" do
      user = User.new(name: "bob", uid: 1)
      order = user.orders.build(status: "unsubmitted")
      user.save!

      Order.first.user.should == user
    end

    it "belongs to an address" do
      address = Address.create!(line1: "32 winter Ave",
                                city: "Grand Heaven",
                                state: "MI",
                                zip: "98101")
      order = Order.new(status: "unsubmitted")
      order.address_id = address.id
      order.save!

      order.address.should == address
    end
  end
end
