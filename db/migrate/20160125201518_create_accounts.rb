class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user,		 		 	index: true, foreign_key: true, null: false
      t.string :password_digest, 	null: false
      t.integer :balance, 		 		null: false, default: 0
      t.string :status, 					null: false, defalut: "active"

      t.timestamps 								null: false
    end
  end
end
