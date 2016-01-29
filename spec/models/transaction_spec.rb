require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:account) { Account.new }
  let(:transaction) { Transaction.new(
    action: "deposit",
    account: account,
    ammount: 10,)
  }

  context "validade presence of" do
    it "action" do
      transaction.action = nil
      expect(transaction).to be_invalid

      expect_error_on transaction,
        method: :action,
        message: 'não pode ficar em branco'
    end

    it "ammount" do
      transaction.ammount = nil
      expect(transaction).to be_invalid

      expect_error_on transaction,
        method: :ammount,
        message: 'não pode ficar em branco'
    end

    it "account" do
      transaction.account = nil
      expect(transaction).to be_invalid

      expect_error_on transaction,
        method: :account,
        message: 'não pode ficar em branco'
    end
  end
end
