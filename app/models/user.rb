class User < ActiveRecord::Base
  has_one :account
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [:cpf]

  delegate :number, to: :account, prefix: :account, allow_nil: true 

  validates :name, presence: true
  validates :cpf, :email, 
    presence: true, 
    :uniqueness => { :case_sensitive => false }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def has_account?
    account.present?
  end
end
