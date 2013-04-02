require_relative "../../app/services/product_presenter"

class Product
  include ProductPresenter
end

describe "Printing Stock" do
  let(:product) { Product.new }

  context "#print_stock" do
    it "says out of stock when no item exists" do
      product.stub(stock: 0)
      product.print_stock.should == 
        "<span class='out_stock'>Out of Stock</span>"
    end

    it "says insufficient when request is more than stock" do
      product.stub(stock: 10)
      product.print_stock(20).should == 
        "<span class='low_stock'>Insufficient Stock</span>"
    end

    it "says in stock when there is stock and more than requested" do
      product.stub(stock: 10)
      product.print_stock(5).should == 
        "<span class='in_stock'>In Stock (10)</span>"
    end
  end
end
