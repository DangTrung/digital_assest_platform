# app/controllers/api/v1/admins_controller.rb
module Api
    module V1
      class AdminsController < ApplicationController
        # Ensure only admins can access this API
        before_action :authenticate_admin!
  
        # Endpoint to list all creators and their total earnings
        def creators_earnings
          # Fetch all users who are creators (assuming a creator is a type of user)
          creators = User.creator
  
          # Create an array of creators with their total earnings
          creators_earnings = creators.map do |creator|
            total_earnings = creator.assets.sum(:price) # Sum of all asset prices for the creator
            {
              creator_id: creator.id,
              name: creator.name,
              total_earnings: total_earnings
            }
          end
  
          # Respond with JSON
          render json: creators_earnings
        end
  
        private
  
        # Authenticate that the user is an admin
        def authenticate_admin!
          unless current_user&.admin?
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end
      end
    end
  end
  