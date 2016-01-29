class Transaction
  class Transfer
    include Virtus.model

    include ActiveModel::Model

    attr_reader :account, :ammount, :account_target, :password

    attribute :ammount, Decimal
    attribute :account, String
    attribute :account_target, String
    attribute :password, Integer
    attribute :action, String, :default => "Transferência"

    validates :ammount, :account, :account_target, :presence => true
    validate  :account_balance, :check_password, :account_found

    def persisted?
      false
    end

    def find_account
      Account.find_by_id(account)
    end

    def find_account_target
      Account.find_by_id(account_target)
    end

    def authentication  #TODO put it in a policy
      find_account.authenticate(password) if find_account
    end

    def check_password
      errors.add(:password, "Senha ou conta inválida") unless authentication
    end

    def valor_tax
      Transaction::TransferTaxs.new(ammount).calculate
    end

    def have_balance?
      if find_account.present?
        valor = find_account.balance - ammount - valor_tax
        valor > 0
      end
    end

    def account_found
      errors.add(:account, "Conta não encontrada") unless find_account
    end

    def account_balance
      errors.add(:ammount, "Sua conta não pode ficar negativa") unless have_balance?
    end

    def save
      if valid?
        persist!
        true
      else
        false
      end
    end

  private
    def persist!

      @transaction = Transaction.create!(
        account:        find_account,
        account_target: find_account_target,
        ammount:        - ammount,
        action:         action)

      Transaction::Deposit.new(
        {ammount: ammount, account: find_account_target, location: find_account}).save

      Transaction::Tax.new(find_account, ammount).save
    end
  end
end