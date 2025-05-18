class Customer::PurchasesController < ApplicationController
  before_action :authenticate_user!, :require_customer!
  before_action :load_purchase, only: [:index]
  before_action :set_purchase, only: [:show]

  def index
  end

  def show
  end

  private

  def set_purchase
    @purchase = current_user.purchases.includes(:assets).find(params[:id])
  end

  def load_purchase
    @purchases = current_user.purchases
    return if @purchases

    flash[:danger] = "Your Purchase is empty !"
    redirect_to customer_assets_path
  end

  def require_customer!
    redirect_to root_path, alert: "Only customers can make purchases" unless current_user.customer?
  end
end
