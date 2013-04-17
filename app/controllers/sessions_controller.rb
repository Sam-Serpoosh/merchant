class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by_auth(authentication_info)
    session[:user_id] = @user.id
    load_order
    @order.update_attributes!(user: @user)
    redirect_to products_path, notice: "Logged in as #{@user.name}"
  end

  def destroy
    log_out
    redirect_to root_path, notice: "Goodbye!"
  end

  def authentication_info
    request.env["omniauth.auth"]
  end

  private

  def log_out
    session[:order_id] = nil
    session[:user_id] = nil
    self.current_user = nil
  end
end
