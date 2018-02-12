class CartsController < ApplicationController
before_action :set_cart
 
  def show
  end

  def checkout
    @current_cart.checkout
    current_user.update(:current_cart_id => nil)
    redirect_to cart_path(@current_cart)
  end

  def create
  end

  private
    def set_cart
      @current_cart = Cart.find_by(params[:id])
    end
 end