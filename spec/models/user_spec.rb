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

    it "has many addresses" do
      user = User.new(name: "bob", uid: 1)
      user.addresses.build(line1: "32 winter Ave", 
                           city: "Grand Heaven", 
                           state: "MI", 
                           zip: "98101")
      user.save!

      user.addresses.count.should == 1
      user.addresses.first.city.should == "Grand Heaven"
    end
  end
end
