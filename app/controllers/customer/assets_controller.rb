# app/controllers/customer/assets_controller.rb
class Customer::AssetsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_customer!
  
    # Action for customer to view available assets
    def index
        @assets = Asset.all
    end
  end
