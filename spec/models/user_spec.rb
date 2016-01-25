require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(
    name: "Juarez", 
    cpf: "0454538745", 
    email: "julustosa@gmail.com", 
    password: "12345678", 
    password_confirmation: "12345678") }

  let(:user_saved) { FactoryGirl.create(:user)}


  context "validate presence of" do
    before do 
      expect(user).to be_valid 
    end

    it "name" do
      user.name = nil
      expect(user).to be_invalid
    end        

    it "Cpf" do
      user.cpf = nil
      expect(user).to be_invalid
    end    
  end

  context "uniqueness" do
    before do 
      user_saved
    end

    it "cpf" do
      user.cpf = user_saved.cpf
      expect(user).to be_invalid
    end        
  end

  context "email" do
    it "not to be required" do
      expect(user).not_to be_email_required
    end

    it "not to be changed" do
      expect(user).not_to be_email_changed
    end
  end  
end
