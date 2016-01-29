require 'rails_helper'

RSpec.describe Transaction::Transfer do
  let(:ammount) {100.90}
  let(:negative_ammount) {-100.90}
  let(:account) { Account.new }
  let(:account_target) { Account.new }
  let(:params){ {"account"=> account, "ammount"=> ammount, "account_target" => account_target} }
  let(:params_negative_ammount){ {"account"=> account, "ammount"=> negative_ammount} }

  let(:transfer) { Transaction::Transfer.new(params) }

  before do
    allow(transfer).to receive(:authentication).and_return (true)
    allow(account).to receive(:balance).and_return (1000.00)
    allow(transfer).to receive(:find_account).and_return (account)
    allow(transfer).to receive(:find_account_target).and_return (account_target)
  end

 context "instance" do
    it "save" do
      allow(transfer).to receive(:find_account).and_return (account)
      expect(transfer.save).to be_truthy
    end
  end

  context "authetication account" do
    it "return a error in a wrong password" do
      allow(transfer).to receive(:authentication).and_return (false)
      expect(transfer.save).to be_falsey
      expect(transfer.errors[:password]).to eq (["Senha ou conta inválida"])
    end
  end

  context "account" do
    context "not found" do
      before do allow(transfer).to receive(:find_account).and_return (nil) end

      it "can't be save" do
        expect(transfer.save).to be_falsey
      end

      it "content a error" do
        transfer.save
        expect(transfer.errors[:account]).to eq (["Conta não encontrada"])
      end
    end

    context "balance return error" do
      it "if greather 0" do
        allow(account).to receive(:balance).and_return (0)
        expect(transfer.save).to be_falsey
        transfer.save
        expect(transfer.errors[:ammount]).to eq (["Sua conta não pode ficar negativa"])
      end

      it "tax greather than ammount" do
        allow(account).to receive(:balance).and_return (10)
        allow(transfer).to receive(:valor_tax).and_return (200)
        expect(transfer.save).to be_falsey
        transfer.save
        expect(transfer.errors[:ammount]).to eq (["Sua conta não pode ficar negativa"])
      end
    end

    it "validate presence" do
      expect(Transaction::Transfer.new({"account"=> nil, "ammount"=> ammount}).save).to be_falsey
    end
  end

  context "validate presence" do
    it "ammount" do
      expect(Transaction::Transfer.new({"account"=> account, "ammount"=> nil}).save).to be_falsey
    end
  end

  context "action" do
    it "return string" do
      expect(transfer.action).to eq("Transferência")
    end
  end
end
