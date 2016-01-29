class Transaction
  class Withdraw
    include Virtus.model

    include ActiveModel::Model

    attr_reader :account, :ammount, :password

    attribute :ammount, Decimal
    attribute :account, String
    attribute :password, Integer

    validates :ammount, :account, :presence => true
    validate  :account_balance, :check_password, :account_notfound

    def persisted?
      false
    end

    def find_account
      Account.find_by_id(account)
    end

    def authentication  #TODO put it in a policy
      find_account.authenticate(password) if find_account
    end

    def check_password
      errors.add(:password, "Senha ou conta inválida") unless authentication
    end

    def have_balance?
      if find_account.present?
        valor = find_account.balance - ammount
        valor < 0
      end
    end

    def account_balance
      errors.add(:ammount, "Sua conta não pode ficar negativa") if have_balance?
    end

    def account_notfound
      errors.add(:account, "Conta não encontrada") unless find_account
    end

    def action
      "withdraw"
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
      @transaction = Transaction.create!(account: find_account, ammount: - ammount, action: action)
    end
  end
end