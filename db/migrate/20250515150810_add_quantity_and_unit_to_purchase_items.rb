class AddQuantityAndUnitToPurchaseItems < ActiveRecord::Migration[8.0]
  def change
    add_column :purchase_items, :quantity, :integer
    add_column :purchase_items, :unit, :string
  end
end
