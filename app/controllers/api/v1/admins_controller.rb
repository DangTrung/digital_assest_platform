# app/controllers/api/v1/admins_controller.rb
module Api
    module V1
      class AdminsController < ApplicationController
        before_action :authenticate_user!
        before_action :authenticate_admin!
  
        def creators_earnings
          creators_earnings = creators_earnings_data.map do |row|
            {
              creator_id: row[0],
              total_earnings: row[1]
            }
          end
  
          render json: creators_earnings
        end
  
        private

        def creators_earnings_data
          ActiveRecord::Base.connection.execute(
            <<~SQL.squish,
              select
                u.id,
                sum(a.price * pi.quantity) as total_earnings
              from
                purchases p
                join purchase_items pi on p.id = pi.purchase_id
                join assets a on pi.asset_id = a.id
                join users u on a.user_id = u.id
              where
                u.role = 1
              group by
                u.id
              order by
                u.id
            SQL
            ).values
        end
  
        def authenticate_admin!
          unless current_user&.admin?
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end
      end
    end
  end
  