FactoryGirl.define do
  factory :account do
    user
	password "123456"
	password_digest "123456"
	balance 0
	status "active"
  end
end
