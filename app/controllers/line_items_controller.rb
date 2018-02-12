class LineItemsController < ApplicationController
  def create
    @cart = current_user.current_cart
    if @cart.nil?
      @cart = current_user.carts.build
    end
    current_user.current_cart = @cart
    item = Item.find_by(id: params[:item_id])
    line_item = @cart.add_item(item.id)
    line_item.save
    current_user.save
    redirect_to cart_path(@cart)
  end
end
