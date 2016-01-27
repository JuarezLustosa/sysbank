require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
	describe 'user access' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id   
    end
  end
end

