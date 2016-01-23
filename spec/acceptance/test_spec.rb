feature "I want be a new client", %q{
  As a person
  I want be a client of bank
  To use banck services
} do
  
  background do
    
  end

  scenario "make a new client register" do

    visit root_path
    page.should have_content "Seja Bem Vindo ao Banco Gold..."
    page.should have_content "Se não é nosso corentissa, 
                              o que esa esperando, 
                              venha fazer parte do banco que mais cresce,
                              click no link abaixa e cadastre-se"
                              
    click_link "Add a new list"
    fill_in "Description", :with => "My new list"
    check("Public")
    
    click_button("Create List")
    re
    page.should have_content "My new list"
    page.should have_content "TODO"
  end
end