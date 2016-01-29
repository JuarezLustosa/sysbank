class Transactions::TransferController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction::Transfer.new(params[:transaction] || params[:transaction_transfer])

    if @transaction.save
      flash[:success] = "Transferência realizada com sucesso"
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
