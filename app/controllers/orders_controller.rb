class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def purchase
    submit_order
    if @order.save
      session[:order_id] = nil
      redirect_to @order, :notice  => "Successfully updated order."
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to products_path, :notice => "Successfully destroyed order."
  end

  private

  def submit_order
    @order = Order.find(params[:id])
    @order.address_id = params[:order].delete(:address_id)
    @order.status = "submitted"
  end
end
