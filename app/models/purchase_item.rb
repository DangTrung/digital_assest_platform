class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :asset
end
