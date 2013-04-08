require 'spec_helper'

describe Address do
  let(:attrs) do
    {
      line1: "32 winter, NE",
      line2: "Room #338",
      city: "Grand Heaven",
      state: "MI",
      zip: "98101"
    }
  end

  context "#creation" do
    it "sets the attributes" do
      address = Address.create!(attrs)
      address.line1.should == "32 winter, NE"
      address.zip.should == "98101"
      address.state.should == "MI"
    end
  end

  context "#validation" do
    it "is not valid without line1" do
      address = Address.new(attrs.merge!(line1: ""))
      address.should_not be_valid
    end

    it "is not valid without city" do
      address = Address.new(attrs.merge!(city: ""))
      address.should_not be_valid
    end

    it "is not valid without state" do
      address = Address.new(attrs.merge!(state: ""))
      address.should_not be_valid
    end

    it "needs the state to be 2 upper case letters" do
      address = Address.new(attrs.merge!(state: "mi"))
      address.should_not be_valid
    end

    it "is not valid without zip" do
      address = Address.new(attrs.merge!(zip: ""))
      address.should_not be_valid
    end

    it "needs the zip code to be EXACTLY 5 digits" do
      address = Address.new(attrs.merge!(zip: "9810"))
      address.should_not be_valid
    end
  end

  context "#association" do
    it "belongs to a user" do
      user = User.new(name: "sam", provider: "twitter", uid: 1)
      user.addresses.build(attrs)
      user.save!

      Address.find_by_user_id(user.id).user.should == user
    end

    it "has many orders" do
      user = User.create!(name: "Bob")
      address = create_address
      address.orders.build(status: "unsubmitted")
      address.save!

      address.orders.count.should == 1
      address.orders.first.status.should == "unsubmitted"
    end
  end

  context "#to_s" do
    it "gives a standard address format" do
      address = create_address
      address.to_s.should == "32 winter Ave, Grand Heaven, MI 98101"
    end
  end
end
