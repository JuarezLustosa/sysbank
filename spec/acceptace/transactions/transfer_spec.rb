require 'rails_helper'

feature "I want transfer my money", %q{
  As a client
  I want transfer my money to another account
} do

  let(:user)    { create(:user)}
  let(:account) { create(:account)}
  let(:account_to_transfer) { create(:account)}
  let(:ammount) { 150.30 }
  let(:ammount_to_tranfer) { 50.00 }
  let(:transaction_deposit) {create(:transaction, account: account, ammount: ammount, action: "Deposito" )}
  let(:tax) { Transaction::TransferTaxs.new(ammount).calculate }

  background do
    login_as(user, :scope => :user)
  end

  scenario "transfer" do
    transaction_deposit
    visit root_path

    click_link 'Transferir'
    expect(page).to have_content "Realizar Transferência"

    fill_in "Valor",               with: ammount_to_tranfer
    fill_in "Conta para deposito", with: account_to_transfer.id
    fill_in "Sua Conta",               with: account.id
    fill_in "Senha da conta",      with: account.password

    click_button "Transferir"

    expect(page).to have_content "Transferência realizada com sucesso"
    expect(page).to have_content "Seu saldo é de R$ #{balance}"
  end

  def balance# check tax
    ammount - ammount_to_tranfer - tax.to_d
  end
end