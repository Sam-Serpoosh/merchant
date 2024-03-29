class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  helper_method :current_user

  def load_order
    @order = Order.find_or_initialize_by_id(
      session[:order_id], 
      status: "unsubmitted")
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
    connect_current_user_to_order
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end

  private

  def not_found
    render file: "public/404.html", status: 404, layout: false
  end

  def connect_current_user_to_order
    if current_user
      @order.update_attributes!(user: current_user)
    end
  end
end
