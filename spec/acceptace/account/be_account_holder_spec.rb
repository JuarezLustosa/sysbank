require 'rails_helper'

feature "I want create my account", %q{
  As a person
  I want create account in the bank
  To use bank services
} do

  let(:user) { create(:user)}

  background do
    login_as(user, :scope => :user)
  end

  scenario "create account" do
    visit root_path
    click_link 'Cadastrar Conta'
    expect(page).to have_content "Abrir uma nova conta"

    fill_in "Senha da conta", :with => "121212"
    fill_in "Confirme a senha", :with => "121212"

    find('input#submit').click # TODO check why click_button does't work

    expect(page).to have_content "#{user.name} o número da sua conta é #{user.account_number}"
    expect(page).to have_content "Por favor não aceite ajuda de estranhos! Guarde bem a sua senha"
  end
end