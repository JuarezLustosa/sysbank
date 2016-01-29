class Account < ActiveRecord::Base

  has_secure_password
  belongs_to :user
  after_initialize :set_initial_status
  delegate :name, :cpf, to: :user, prefix: true, allow_nil: true
  has_many :transactions

  validates :password, length: 6..6, :presence => true, on: :create
  validates :user, :status, :presence => true

	def set_initial_status
  	self.status ||= "active"
  end

  def number
    id
  end

  def self.active
    where(status: "active")
  end

  def has_balance?
    balance > 0
  end

  def balance
    transactions.sum(:ammount)
  end

  def close #TOTO put it in a Policy
    if has_balance?
      errors.add(:base, "Sua Conta não pode ser encerrada, pois ela possui saldo.")
    else
      update(status: "closed")
    end
  end
end
