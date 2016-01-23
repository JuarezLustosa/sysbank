module Loggin
  module Helper
    
    def current_user
      @current_user ||= FactoryGirl.create(:user)
    end

    def sign_out
      Capybara.reset_sessions!
      logout(:user)
    end

    def sign_in
      login_as(current_user)
    end
  end 
end