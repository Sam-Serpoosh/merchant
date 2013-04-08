class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(params[:address])
    if @address.save
      load_order
      redirect_to order_path(@order)
    else
      render action: "new" 
    end
  end
end
