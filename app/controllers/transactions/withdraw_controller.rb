class Transactions::WithdrawController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction::Withdraw.new(params[:transaction] || params[:transaction_withdraw])

    if @transaction.save
      flash[:success] = "Saque realizado com sucesso"
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  private
  def withdraw_params
    params.require(:transaction).permit(:ammount)
  end
end
