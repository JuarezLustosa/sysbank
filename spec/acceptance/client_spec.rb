feature "I want be a new client", %q{
  As a person
  I want be a client of bank
  To use banck services
} do
  
  background do
    
  end

  scenario "register a new client" do

    visit root_path
    page.should have_content "Seja Bem Vindo ao Banco Gold..."
    page.should have_content "Se não é nosso corentissa, 
                              o que esa esperando, 
                              venha fazer parte do banco que mais cresce,
                              click no botão abaixo e cadastre-se"

    click_link "Cadastrar"
    page.should have_content "Dados cadastrais do Cliente"

    fill_in "Nome", :with => "Juarez Lustosa"
    fill_in "Cpf", :with => "1231233331232" #TODO make a generator
    fill_in "Senha", :with => "12345678"
    fill_in "Confirmação de senha", :with => "12345678"
    fill_in "email", :with => "juarez.lustosa@gmail.com"

    click_button("Tornar-se Correntista")
    
    page.should have_content "Parabéns seu cadastro foi realizado com sucesso. Seja Bem Vindo!"
  end
end