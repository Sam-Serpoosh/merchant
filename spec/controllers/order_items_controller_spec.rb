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

  describe "updating" do
    it "removes the item when updating the quantity to 0" do
      item = stub.as_null_object
      item.should_receive(:destroy)
      OrderItem.stub(:find) { item }

      put :update, id: 1, order_item: { quantity: 0 }
    end

    it "updates the item with valid information" do
      item = OrderItem.create!(order_id: 1, product_id: 1, quantity: 1)
      put :update, id: item.id, order_item: { quantity: 10 }

      OrderItem.first.quantity.should == 10
    end
  end

  describe "destroying" do
    it "removes the item and redirect to order show" do
      order_item = OrderItem.create!(order_id: 1, product_id: 1, quantity: 1)
      lambda do
        delete :destroy, id: order_item.id
        response.should redirect_to(order_path(assigns(:order)))
      end.should change(OrderItem, :count).by -1
    end
  end
end
