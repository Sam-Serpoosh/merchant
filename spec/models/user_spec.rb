require 'spec_helper'

describe User do
  context "#association" do
    it "has many orders" do
      user = User.new(name: "bob", uid: 1)
      user.orders.build(status: "unsubmitted")
      user.orders.build(status: "submitted")
      user.save!

      user.orders.count.should == 2
    end
  end
end
