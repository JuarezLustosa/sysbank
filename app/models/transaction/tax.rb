class Transaction
  class Tax
    attr_reader :account, :ammount

    def initialize(account, ammount)
      @account = account
      @ammount = ammount
    end

    def calculate_tax
      Transaction::TransferTaxs.new(@ammount).calculate
    end

    def debit
      - calculate_tax
    end

    def save
      @transaction = Transaction.new
      @transaction.account = @account
      @transaction.ammount = debit
      @transaction.action  = 'Taxa Transferência'
      @transaction.save
    end
  end
end