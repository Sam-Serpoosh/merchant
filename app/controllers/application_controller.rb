class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def load_order
    @order = Order.find_or_initialize_by_id(session[:order_id], 
                                            status: "unsubmitted")
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
    connect_current_user_to_order
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      @current_user = nil
    end
  end

  private

  def connect_current_user_to_order
    if current_user
      @order.update_attributes!(user: current_user)
    end
  end
end
