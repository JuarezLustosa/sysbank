class Transactions::WithdrawController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @account = Account.find_by_id(params[:transaction][:account])
    @transaction = Transaction::Withdraw.new(params[:transaction])

    if @transaction.save
      flash[:success] = "Saque realizado com sucesso"
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
