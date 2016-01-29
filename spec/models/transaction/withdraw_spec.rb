require 'rails_helper'

RSpec.describe Transaction::Withdraw do
  let(:ammount) {100.90}
  let(:negative_ammount) {-100.90}
  let(:account) { Account.new }
  let(:params){ {"account"=> account, "ammount"=> ammount} }
  let(:params_negative_ammount){ {"account"=> account, "ammount"=> negative_ammount} }

  let(:withdraw) { Transaction::Withdraw.new(params) }

  before do
    allow(withdraw).to receive(:authentication).and_return (true)
    allow(account).to receive(:balance).and_return (1000.00)
    allow(withdraw).to receive(:find_account).and_return (account)
  end

  context "authetication account" do
    it "return a error in a wrong password" do
      allow(withdraw).to receive(:authentication).and_return (false)
      expect(withdraw.save).to be_falsey
      expect(withdraw.errors[:password]).to eq (["Senha ou conta inválida"])
    end
  end

  context "instance" do
    it "save" do
      expect(withdraw.save).to be_truthy
    end
  end

  context "account" do
    context "not found" do
      before do allow(withdraw).to receive(:find_account).and_return (nil) end

      it "can't be save" do
        expect(withdraw.save).to be_falsey
      end

      it "content a error" do
        withdraw.save
        expect(withdraw.errors[:account]).to eq (["Conta não encontrada"])
      end
    end

    it "should have balance" do
      allow(account).to receive(:balance).and_return (0)
      expect(withdraw.save).to be_falsey
      withdraw.save
      expect(withdraw.errors[:ammount]).to eq (["Sua conta não pode ficar negativa"])
    end

    it "validate presence" do
      expect(Transaction::Withdraw.new({"account"=> nil, "ammount"=> ammount}).save).to be_falsey
    end
  end

  context "validate presence of" do
    it "ammount" do
      expect(Transaction::Withdraw.new({"account"=> account, "ammount"=> nil}).save).to be_falsey
    end
  end

  context "action" do
    it "must save a string deposit" do
      expect(withdraw.action).to eq("withdraw")
    end
  end
end
