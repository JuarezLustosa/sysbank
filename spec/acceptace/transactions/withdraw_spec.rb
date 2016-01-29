require 'rails_helper'

feature "I want withdraw my money", %q{
  As a client
  I want withdraw my money in my account bank
  To spend my money
} do

  let(:user)    { create(:user)}
  let(:account) { create(:account)}
  let(:ammount) { 150.30 }
  let(:transaction_deposit) {create(:transaction, account: account, ammount: ammount, action: "Deposito" )}

  background do
    login_as(user, :scope => :user)
    account
  end

  scenario "take my money" do
    transaction_deposit
    visit root_path

    click_link 'Sacar'
    expect(page).to have_content "Realizar Saque"

    fill_in "Valor", :with =>  ammount
    fill_in "Conta", :with => "#{account.id}"
    fill_in "Senha da conta", :with => account.password

    click_button "Sacar"

    expect(page).to have_content "Saque realizado com sucesso"
    expect(page).to have_content "Seu saldo é de R$ 0.0"
  end

  scenario "can't withdraw more than I have" do

    visit root_path

    click_link 'Sacar'
    expect(page).to have_content "Realizar Saque"

    fill_in "Valor", :with =>  ammount
    fill_in "Conta", :with => "#{account.id}"
    fill_in "Senha da conta", :with => account.password

    click_button "Sacar"

    expect(page).to have_content "Sua conta não pode ficar negativa"
  end
end