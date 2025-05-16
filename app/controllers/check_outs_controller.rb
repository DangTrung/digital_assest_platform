class CheckOutsController < ApplicationController
  before_action :authenticate_user!, :load_purchase
  def index
  end

  def update
    binding.pry
    if @purchase.update(payable: true)
      flash[:success] = "Your are checked. Check your mail please "
      redirect_to root_path
      session[:purchase] = nil
    else
      flash[:now] = "checked fails"
      render :index
    end
  end

  private

  def load_purchase
    @purchase = session[:purchase_id].nil? ? Purchase.new : Purchase.find(session[:purchase_id])
    return if @purchase

    flash[:danger] = "Your Cart is empty !"
    redirect_to purchase_items_path
  end

  def order_params
    params.require(:purchase)
  end
end
