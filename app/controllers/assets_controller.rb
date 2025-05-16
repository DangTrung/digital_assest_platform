class AssetsController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is logged in
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  def index
    @assets = Asset.all
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # POST /assets
  def create
    @asset = current_user.assets.build(asset_params)  # Assuming each user can have many assets
    if @asset.save
      redirect_to @asset, notice: 'Asset was successfully created.'
    else
      render :new
    end
  end

  # GET /assets/:id
  def show
  end

  # GET /assets/:id/edit
  def edit
  end

  # PATCH/PUT /assets/:id
  def update
    if @asset.update(asset_params)
      redirect_to @asset, notice: 'Asset was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /assets/:id
  def destroy
    @asset.destroy
    redirect_to assets_url, notice: 'Asset was successfully destroyed.'
  end

  private

  # Set asset for actions that need it (show, edit, update, destroy)
  def set_asset
    @asset = Asset.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def asset_params
    params.require(:asset).permit(:name, :description, :file, :price)  # Adjust based on your Asset model's attributes
  end
end
