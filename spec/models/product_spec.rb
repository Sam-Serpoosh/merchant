require 'spec_helper'

describe Product do
  context "#validation" do
    it "only accepts integers for stock" do
      p = Product.new(price: "25.99", stock: 10)
      p.should be_valid
    end

    it "rejects non-integer stock values" do
      p = Product.new(price: "20", stock: 10.99)
      p.should_not be_valid
    end

    it "rejects stock less than 0" do
      p = Product.new(price: "20", stock: -10)
      p.should_not be_valid
    end
  end

  context "#initializing" do
    it "removes the $ sign form price value" do
      price = "$$10.99"
      product = Product.new(price: price)
      product.price.should == 10.99
    end
  end
end
