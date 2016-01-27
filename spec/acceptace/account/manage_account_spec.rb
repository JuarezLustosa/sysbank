require 'rails_helper'

feature "I want manage my account", %q{
  As a person
  I want change my account informations
} do

  let(:account) {create(:account)}

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
end