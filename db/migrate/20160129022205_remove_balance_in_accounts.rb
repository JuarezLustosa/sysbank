class RemoveBalanceInAccounts < ActiveRecord::Migration
  def change
   remove_column :accounts, :balance
  end

  def down
    add_column :accounts, :balance, null: false
  end
end
