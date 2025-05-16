class AddPayableToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :payable, :boolean
  end
end
