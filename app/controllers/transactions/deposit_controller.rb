class Transactions::DepositController < ApplicationController
  def new
    @transaction = Transaction.new
  end

 def create
    @transaction = Transaction::Deposit.new(params[:transaction])

    if @transaction.save
      flash[:success] = "Deposito realizado com sucesso"
      redirect_to root_path
    else
      render action: 'new'
    end
  end

private
  def deposit_params
    params.require(:transaction).permit(:ammount)
  end
end
