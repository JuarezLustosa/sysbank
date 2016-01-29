class TransactionsController < ApplicationController
  respond_to :js

  def index
    start_date = params[:date_start] if params[:date_start].present?
    end_date   = params[:date_end] if params[:date_end].present?
    @account   = Account.find_by_id(params[:account])

    @statements = Transaction.by_account(@account).at_date(start_date, end_date)
    respond_with @statements
  end
end
