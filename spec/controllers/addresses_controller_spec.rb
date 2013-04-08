require 'spec_helper'

describe AddressesController do
  describe "creating" do
    let(:current_user) { @current_user }
    let(:address_attr) do
      {
        line1: "32 winter Ave",
        city: "Grand Heaven",
        state: "MI",
        zip: "98101"
      }
    end

    before do
      @current_user = User.create!(name: "Bob", uid: 1)
    end

    it "sets the user to the current_user" do
      User.stub(:find) { current_user }
      post :create, address: address_attr

      current_user.addresses.first.zip.should == "98101"
    end
  end
end
