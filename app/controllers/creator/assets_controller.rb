class Creator::AssetsController < ApplicationController
    before_action :authenticate_user!  # Ensure the user is signed in
    before_action :set_asset, only: [:show, :edit, :update, :destroy]
    before_action :require_creator!
    
    # Show only the assets of the current user
    def index
      @assets = current_user.assets
    end
  
    def show
      # @asset is already set by the set_asset before_action
    end
  
    def new
      @asset = current_user.assets.new # Ensure the asset is created by the current user
    end
  
    def create
      @asset = current_user.assets.new(asset_params)  # Ensure the asset is created by the current user
      if @asset.save
        redirect_to creator_asset_path(@asset), notice: 'Asset created successfully'
      else
        render :new
      end
    end
  
    def edit
      # @asset is already set by the set_asset before_action
    end
  
    def update
      if @asset.update(asset_params)
        redirect_to creator_asset_path(@asset), notice: 'Asset updated successfully'
      else
        render :edit
      end
    end
  
    def destroy
      @asset.destroy
      redirect_to creator_assets_path, notice: 'Asset deleted successfully'
    end
  
    private
  
    def set_asset
      @asset = current_user.assets.find(params[:id])  # Ensure the asset belongs to the current user
    end

    def asset_params
      params.require(:asset).permit(:title, :description, :price, :file_url)
    end
  end
  