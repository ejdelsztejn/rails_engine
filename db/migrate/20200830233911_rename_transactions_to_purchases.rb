class RenameTransactionsToPurchases < ActiveRecord::Migration[5.2]
  def change
    rename_table :transactions, :purchases
  end
end
