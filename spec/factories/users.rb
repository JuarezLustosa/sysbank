FactoryGirl.define do
  factory :user do
  	name 			 				'Juarez Lustosa'
  	sequence(:cpf)   	{|n| "#{n}"} #to avoid uniqueness
  	sequence(:email) 	{|n| "test#{n}@example.com"}
    password 					'f4k3p455w0rd'
  end
end
