class PurchaseItemsController < ApplicationController
  before_action :authenticate_user!
  # before_action :require_customer!
  before_action :set_current_purchase

  def create
    asset_id = purchase_item_params[:asset_id].to_i
    quantity = purchase_item_params[:quantity].to_i

    existing_item = @purchase.purchase_items.find_by(asset_id: asset_id)

    if existing_item
      existing_item.update(quantity: quantity)
      flash[:success] = "Updated quantity in your cart"
    else
      @purchase_item = @purchase.purchase_items.new(asset_id: asset_id, quantity: quantity)
      if @purchase.save && @purchase_item.save
        session[:purchase_id] = @purchase.id
        flash[:success] = "Added to your cart"
      else
        flash[:error] = "Could not add item to cart"
      end
    end

    redirect_back fallback_location: root_path
  end

  def quick_add
    asset_id = params[:asset_id].to_i
    existing_item = @purchase.purchase_items.find_by(asset_id: asset_id)

    if existing_item
      existing_item.increment!(:quantity)
      flash[:success] = "Increased quantity in your cart"
    else
      @purchase_item = @purchase.purchase_items.new(asset_id: asset_id, quantity: 1)
      if @purchase.save && @purchase_item.save
        session[:purchase_id] = @purchase.id
        flash[:success] = "Added to your cart"
      else
        flash[:error] = "Could not add item to cart"
      end
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    item = @purchase.purchase_items.find_by(asset_id: params[:id])
    if item
      item.destroy
      flash[:success] = "Item removed from your cart"
    else
      flash[:alert] = "Item not found"
    end
    redirect_back fallback_location: root_path
  end

  def show
    @purchase_items = @purchase.purchase_items.includes(:asset)
  end

  private

  def set_current_purchase
    @purchase = if session[:purchase_id]
                  Purchase.find_by(id: session[:purchase_id])
                end

    unless @purchase
      @purchase = current_user.purchases.create
      session[:purchase_id] = @purchase.id
    end
  end

  def purchase_item_params
    params.require(:purchase_item).permit(:asset_id, :quantity)
  end

  def require_customer!
    redirect_to root_path, alert: "Only customers can make purchases" unless current_user.customer?
  end
end