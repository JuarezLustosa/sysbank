require 'rails_helper'

RSpec.describe Transactions::TransferController, type: :controller do

  pending "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  pending "GET #create" do
    it "returns http success" do
      stub_account
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
