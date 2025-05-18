module PurchaseItemsHelper
  def price purchase_items
		purchase_items.quantity*purchase_items.asset.price
	end
	
	def total_price purchase_items
		purchase_items.map{|i| i.asset.price*i.quantity}.sum
	end
end
