class Admin::DashBoardsController < ApplicationController
	before_action :authenticate_user!, :require_admin!
	def index
		@creator_total_eanring = TotalEanring.new.creator_total_eanring
		@customer_total_eanring = TotalEanring.new.customer_total_eanring
	end
end
