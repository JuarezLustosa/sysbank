require 'rails_helper'

feature "I want manage my account", %q{
  As a person
  I want change my account informations
} do

  let(:account) {create(:account)}
  let(:ammount) { 150.30 }
  let(:transaction_deposit) {create(:transaction, account: account, ammount: ammount, action: "Deposito" )}

  background do
    login_as(account.user, :scope => :user)
  end

  scenario "edit account" do
    visit root_path
    click_link 'Alterar Senha de Conta'
    expect(page).to have_content "Editar a senha da sua conta número"

    fill_in "Senha da conta", :with => "121212"
    fill_in "Confirme a senha", :with => "121212"

    find('input#submit').click # TODO check why click_button does't work

    expect(page).to have_content "Deseja realizar um deposito"
    expect(page).to have_content "Deseja realizar um tranferência"
    expect(page).to have_content "Deseja realizar um saque"
  end

  scenario "close account" do
    visit root_path
    click_link 'Encerrar'
    expect(page).to have_content "Encerramento de Conta"

    click_link 'Encerrar conta'

    expect(page).to have_content "Conta encerrada com sucesso"
  end

  scenario "can't close account with balance" do
    transaction_deposit

    visit root_path
    click_link 'Encerrar'
    expect(page).to have_content "Encerramento de Conta"

    within "td#close_button" do
      expect(page).to have_content "Não é possivel encerrar sua conta ela possue saldo!"
      expect(page).to_not have_link 'Encerrar conta'
    end
  end
end