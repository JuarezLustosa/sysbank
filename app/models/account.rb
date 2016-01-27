class Account < ActiveRecord::Base

  has_secure_password
  belongs_to :user
  after_initialize :set_initial_status
  delegate :name, :cpf, to: :user, prefix: true, allow_nil: true

  validates :password, length: 6..6, :presence => true
  validates :user, :status, :presence => true
  validate  :balance_cant_be_negative

  def balance_cant_be_negative
  	errors.add(:balance, "Sua Conta não pode ficar negativa") if balance < 0  	
  end

	def set_initial_status
  	self.status ||= "active"
  end

  def number
    id
  end
end
