class Transaction < ActiveRecord::Base
  belongs_to :account
  attr_accessor :password
  validates :action, :ammount, :account, presence: true

  scope :at_date, lambda { |date_start, date_end| where("created_at >= ? AND created_at <= ?", date_start, date_end) }
  scope :by_account, lambda { |account_id|  where(account_id: account_id) }
end