require 'spec_helper'

class StubSessionsController < SessionsController
  def authentication_info
    {
      "provider" => "twitter",
      "uid" => 1,
      "info" => { "name" => "Bob" }
    }
  end
end

describe StubSessionsController do
  it "connects the user to the order after logging in" do
    post :create
    assigns(:order).user.should == User.find(session[:user_id])
  end

  context "#login&out" do
    it "logs the user in" do
      post :create
      controller.current_user.should_not be_nil
    end

    it "logs the user out and delete the order" do
      post :create
      delete :destroy
      controller.send(:current_user).should be_nil
      session[:order_id].should be_nil
    end
  end
end
