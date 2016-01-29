require 'rails_helper'

RSpec.describe Transaction::TransferTaxs do
  let(:ammount) { 999 }
  let(:transfer_taxs) { Transaction::TransferTaxs.new(ammount) }

  context "in a comercial time" do
    it "debit valor 5" do
      comercial_time(transfer_taxs)
      expect(transfer_taxs.calculate).to eq(5)
    end
  end

  context "in a non comercial time" do
    it "debit valor 7" do
      non_comercial_time(transfer_taxs)
      expect(transfer_taxs.calculate).to eq(7)
    end
  end

  context "exceed valor 1000" do
    before do
      @execeeded_valor = Transaction::TransferTaxs.new(1000.01)
    end

    context "in comercial time" do
      it "debit valor 10 plus 5" do
        comercial_time(@execeeded_valor)
        expect(@execeeded_valor.calculate).to eq(15)
      end
    end

    context "in non comercial time" do
      it "debit valor 10 plus 7" do
        non_comercial_time(@execeeded_valor)
        expect(@execeeded_valor.calculate).to eq(17)
      end
    end
  end

  def non_comercial_time(transfer_taxs)
    allow(transfer_taxs).to receive(:weekend?).and_return(true)
    allow(transfer_taxs).to receive(:cover_time?).and_return(false)
  end

  def comercial_time(transfer_taxs)
    allow(transfer_taxs).to receive(:weekend?).and_return(false)
    allow(transfer_taxs).to receive(:cover_time?).and_return(true)
  end
end
