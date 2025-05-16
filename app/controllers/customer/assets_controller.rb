# app/controllers/customer/assets_controller.rb
class Customer::AssetsController < ApplicationController
    before_action :authenticate_user!
  
    # Action for customer to view available assets
    def index
    #   if current_user.admin?
    #     @assets = Asset.all  # Or modify to only show assets available to customers
    #   else
    #     redirect_to root_path, alert: "You must be a customer to view assets."
    #   end
    @assets = Asset.all
    end
  end
