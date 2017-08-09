FactoryGirl.define do
  factory :post do
    name { Faker::Lorem.sentence 5 }
    content { Faker::Lorem.paragraph }
    author
  end
end
