module ApplicationHelper
    def current_purchase 
		session[:purchase_id].nil? ? current_user.purchases.new : Purchase.find(session[:purchase_id])
	end
end
