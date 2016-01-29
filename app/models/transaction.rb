class Transaction < ActiveRecord::Base
  belongs_to :account
  attr_accessor :password
  validates :action, :ammount, :account, presence: true
end
