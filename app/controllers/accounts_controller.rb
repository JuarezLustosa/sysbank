class AccountsController < ApplicationController
	before_action :build_account

	def show
		respond_with @account
	end

	def create
		#@account = Account.new(account_params)
		@account.user = current_user
		@account.save
		respond_with @account
	end

	def update
		@account.save
		respond_with @account
	end

private
	def account_params
		params.require(:account).permit(:password, :password_confirmation, :user, :status)
	end

	def build_account
		@account ||= params[:id].present? ? Account.find(params[:id]) : Account.new
    @account.attributes = account_params if params[:account]
	end

	def respond_with_diferente_location
		respond_with @account, :location => root_path 
	end
end
