module CheckOutsHelper
    def purchase_items
		@purchase.purchase_items.includes(:asset)
	end

	def value_ordeded
		current_user&.purchases.last
	end
end
