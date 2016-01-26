require 'rails_helper'

feature "I want to have access in the bank", %q{
  As a person
  I want be a client of bank
  To use bank services
} do
  
  background do
    
  end

  scenario "register a new client" do
    visit root_path
    expect(page).to have_content "Seja Bem Vindo ao Banco Gold..."
    expect(page).to have_content "Se não é nosso corentissa, 
                                  o que esa esperando, 
                                  venha fazer parte do banco que mais cresce,
                                  click no botão abaixo e cadastre-se"

    click_link "Cadastrar"
    expect(page).to have_content "Dados cadastrais do Cliente"

    fill_in "Nome", :with => "Juarez Lustosa"
    fill_in "Cpf", :with => "1231233331232" #TODO make a generator
    fill_in "Senha", :with => "12345678"
    fill_in "Confirmação de senha", :with => "12345678"
    fill_in "email", :with => "juarez.lustosa@gmail.com"

    click_button("Tornar-se Correntista")
    
    expect(page).to have_content "Parabéns seu cadastro foi realizado com sucesso. 
                                  Seja Bem Vindo!"
  end

  scenario "log in" do
    user = create(:user)

    visit root_path

    expect(page).to have_content "Se você já possui uma conta favor clicar no 
                                  link abaixo e efutar o logo, 
                                  para que você tenha acesso aos nossos serviços"
    click_link("Logar no sistema")
   
    expect(page).to have_content "Logar no sistema"
   
    fill_in "Cpf", :with => "#{user.cpf}"
    fill_in "Senha", :with => "#{user.password}"

    click_button('Logar')
    expect(page).to have_content "Bem Vindo ao nosso sistema!!"
  end
end