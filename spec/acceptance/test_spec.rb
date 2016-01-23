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
    page.should have_content "Cadastro de Cliente"

    fill_in "Name", :with => "Juarez Lustosa"
    fill_in "CPF", :with => "1231233331232" #TODO make a generator
    fill_in "Birthdate", :with => "30/04/1983"
    fill_in "password", :with => "123456"
    fill_in "password_confirmation", :with => "123456"
    fill_in "email", :with => "juarez.lustosa@gmail.com"

    click_button("Salvar")
    
    page.should have_content "Parabéns você é o nosso mais novo correntista."
    page.should have_content "Anote o número da sua conta e senha"
    page.should have_content "Essa senha é uma senha deve ser trocar, por favor click para altera-la."
  end
end