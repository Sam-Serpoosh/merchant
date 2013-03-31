class OrderItemsController < ApplicationController
  before_filter :load_order

  def show
    @order_item = OrderItem.find params[:id]
  end

  def create
    @order_item = @order.order_items.
      find_or_initialize_by_product_id(params[:product_id])
    @order_item.quantity += 1
    if @order_item.save!
      redirect_to @order, :notice => "Successfully created order item."
    else
      render action: new
    end
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def update
    if zero_item?
      remove_item
    else
      update_item
    end
  end

  def destroy
    remove_item
  end

  private 
  
  def zero_item?
    params[:order_item][:quantity].to_i == 0
  end

  def remove_item
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to order_path(@order), 
      :notice => "Successfully removed item."
  end

  def update_item
    @order_item = OrderItem.find(params[:id])
    if @order_item.update_attributes(params[:order_item])
      redirect_to @order, :notice  => "Successfully updated item."
    else
      render action: "edit"
    end
  end
end
