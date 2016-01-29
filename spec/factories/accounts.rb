FactoryGirl.define do
  factory :account do
    user
  	password "123456"
  	status "active"
  end
end
