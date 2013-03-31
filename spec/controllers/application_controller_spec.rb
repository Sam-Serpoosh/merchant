require 'spec_helper'

describe ApplicationController do
  context "#load_order" do
    it "loads the order if already exists" do
      order = Order.create!(status: "submitted")
      session[:order_id] = order.id

      controller.load_order
      assigns(:order).status.should == "submitted"
    end

    it "creates a new order when already not exists" do
      controller.load_order
      assigns(:order).status.should == "unsubmitted"
    end
  end
end
