FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.sentence 1 }
    description { Faker::Lorem.paragraph }
  end
end
