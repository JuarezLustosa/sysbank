class Accounts::CloseController < ApplicationController
  def update
    @account = Account.find(params[:account_id])
    @account.close

    diferente_location @account
  end

private
  def diferente_location account
    flash[:success] = "Conta encerrada com sucesso"
    respond_with account, :location => accounts_path
  end
end