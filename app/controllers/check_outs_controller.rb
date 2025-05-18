class CheckOutsController < ApplicationController
  before_action :authenticate_user!, :load_purchase, :require_customer!
  def index
  end

  def update
    if @purchase.update(payable: true)
      session[:purchase_id] = nil
      flash[:success] = "Your are payed. Check your mail please"
      redirect_to customer_purchases_path
    else
      flash[:now] = "checked fails"
      render :index
    end
  end

  private

  def load_purchase
    @purchase = session[:purchase_id].nil? ? Purchase.new : Purchase.find(session[:purchase_id])
    return if @purchase

    flash[:danger] = "Your Purchase is empty !"
    redirect_to purchase_items_path
  end

  def order_params
    params.require(:purchase)
  end
end
