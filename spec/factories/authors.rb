FactoryGirl.define do
  factory :author do
    name 'test author'
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password 'password'
  end
end
