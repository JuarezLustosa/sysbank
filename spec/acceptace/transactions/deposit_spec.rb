require 'rails_helper'

feature "I want deposit my money", %q{
  As a client
  I want deposit my money in my account
  To secure my money
} do

  let(:user)    { create(:user)}
  let(:account) { create(:account)}
  let(:ammount) { 150.30 }


  background do
    login_as(user, :scope => :user)
    account
  end

  scenario "deposit my money" do
    visit root_path

    click_link 'Depositar'
    expect(page).to have_content "Realizar Deposito"

    fill_in "Valor", :with =>  ammount
    fill_in "Conta", :with => "#{account.id}"

    click_button "Depositar"

    expect(page).to have_content "Deposito realizado com sucesso"
  end
end