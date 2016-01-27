require 'rails_helper'

RSpec.describe Account, type: :model do
	let(:user) { User.new }
  let(:account) { Account.new(
    password: "121212",
    user: user,
    balance: 0,
    status: "active")
  }

  let(:create_account) { create(:account)}

  it "a valid account" do
  	expect(account).to be_valid
  end

  it "change name attribute id to number" do
    allow(account).to receive(:id).and_return(1)
    expect(account.number).to eq 1
  end

  context "in password" do
    it "validade presence" do
      account.password = nil
      expect(account).to be_invalid
     	expect_error_on :password
    end

    context "length" do
		  it "maximun is six numbers" do
		 		account.password = "123456789"
		 		expect(account).to be_invalid
		 		expect_error_on :password
		  end

		  it "minimum is six numbers" do
		 		account.password = "123"
		 		expect(account).to be_invalid
		 		expect_error_on :password
		  end
	  end
  end

  context 'user' do
  	it "validade presence" do
  		account.user = nil
  		expect(account).to be_invalid
  		expect_error_on :user
  	end
  end

  context 'status' do
    it "validade presence" do
      account.status = nil
      expect(account).to be_invalid
      expect_error_on :status
    end

    it "set to active in new instance" do
      account = Account.new
      expect(account.status).to eq "active"
    end
  end

  context 'balance' do
    it "can't be negative" do
      account.balance = -1
      expect(account).to be_invalid
      expect_error_on :balance
    end
  end

  context 'filter active account' do
     before :each do
      @active  = create(:account)
      @closed  = create(:account, status: "closed")
    end

    context "with matching active" do
      it "returns a sorted array of results that match" do
        expect(Account.active).to eq [@active]
      end
    end

    context "with non-matching active" do
      it "omits results" do
        expect(Account.active).to_not eq [@closed]
      end
    end
  end

  context "close down" do
    it "if has balance" do
      allow(account).to receive(:has_balance?).and_return(true)
      allow(account.close)
      expect_error_on :balance
    end
  end
end
