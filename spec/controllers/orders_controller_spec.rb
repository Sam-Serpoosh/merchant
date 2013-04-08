require 'spec_helper'

describe OrdersController do
  describe "updating" do
    before do
      @user = User.create!(name: "Bob")
      @order = @user.orders.create!(status: "unsubmitted")
      @address = create_address
    end

    it "sets the address associated with the order while submitting" do
      put :update, id: @order.id, order: { address_id: @address.id }
      Order.first.address.should == @address
    end

    it "sets the status to submitted when submitting the order" do
      put :update, id: @order.id, order: { address_id: @address.id }
      Order.first.status.should == "submitted"
    end
  end
end
