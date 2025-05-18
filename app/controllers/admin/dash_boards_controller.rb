class Admin::DashBoardsController < ApplicationController
	before_action :authenticate_user!, :require_admin!
	def index
		@users_by_day = User.group_by_day(:created_at).count
		@creator_total_eanring = TotalEanring.new.creator_total_eanring
		@customer_total_eanring = TotalEanring.new.customer_total_eanring
	end
end
