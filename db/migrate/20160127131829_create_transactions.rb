class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account, index: true, foreign_key: true, null: false
      t.string :action, null: false
      t.decimal :ammount, null: false
      t.integer :account_target, index:true
      t.integer :location

      t.timestamps null: false
    end
  end
end
