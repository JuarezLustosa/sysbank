class Transactions::TransferController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    params_account = params[:transaction] ? params[:transaction][:account] : params[:transaction_transfer][:account]
    @account = Account.find_by_id(params_account)
    @transaction = Transaction::Transfer.new(params[:transaction] || params[:transaction_transfer])

    if @transaction.save
      flash[:success] = "Transferência realizada com sucesso"
      redirect_to account_path(@account)
    else
      render action: 'new'
    end
  end

  private
  def withdraw_params
    params.require(:transaction).permit(:ammount)
  end
end
