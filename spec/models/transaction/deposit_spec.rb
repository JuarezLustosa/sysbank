require 'rails_helper'

RSpec.describe Transaction::Deposit do
  let(:ammount) {100.90}
  let(:params){ {"account"=> account, "ammount"=> ammount} }
  let(:params_negative_ammount){ {"account"=> account, "ammount"=> negative_ammount} }
  let(:account) { Account.new }
  let(:negative_ammount) { -100 }
  let(:deposit) { Transaction::Deposit.new(params) }

  before do
    allow(deposit).to receive(:find_account).and_return (account)
  end

  context "transaction instance" do
    it "save" do
      expect(deposit.save).to be_truthy
    end
  end

  context "ammount" do
    it "must be greater than 0" do
      expect(Transaction::Deposit.new(params_negative_ammount).save).to be_falsey
    end
  end

  context "validate presence of" do
    it "account" do
      expect(Transaction::Deposit.new({"account"=> nil, "ammount"=> ammount}).save).to be_falsey
    end
  end

  context "account not found" do
    before do allow(deposit).to receive(:find_account).and_return (nil) end

    it "return error" do
      expect(deposit.save).to be_falsey
    end

    it "content a error" do
      deposit.save
      expect(deposit.errors[:account]).to eq (["Conta não encontrada"])
    end
  end

  context "action" do
    it "must save a string deposit" do
      expect(deposit.action).to eq("Deposito")
    end
  end
end
