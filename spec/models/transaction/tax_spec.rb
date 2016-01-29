require 'rails_helper'

RSpec.describe Transaction::Tax do
  let(:ammount) {100.90}
  let(:account) {Account.new}
  let(:tax) { Transaction::Tax.new(account, ammount) }

  context "transaction instance" do
    it "save" do
      expect(tax.save).to be_truthy
    end
  end

  context "debit" do
    it "calculate a tax by time" do
      expect(tax.debit).to_not be_nil
    end
    it "should not be positive" do
      expect(tax.debit).to_not be_positive
    end
  end
end
