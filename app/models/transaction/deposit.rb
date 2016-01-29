ValidationError = Class.new RuntimeError
class Transaction
  class Deposit
    include Virtus.model

    include ActiveModel::Model

    attr_reader :account, :ammount, :location

    attribute :ammount, Decimal
    attribute :account, Integer
    attribute :location, String
    attribute :action, String, :default => "Deposito"

    validates :ammount, :numericality => { :greater_than =>  0 }, :presence => true
    validates :account, :presence => true
    validate  :account_notfound

    def persisted?
      false
    end

    def find_account
      Account.find_by_id(account)
    end

    def account_notfound
      errors.add(:account, "Conta não encontrada") unless find_account
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
        account: find_account,
        ammount: ammount,
        action: action,
        location: location)
    end
  end
end