FactoryGirl.define do
  factory :appartment do
    address { 'Prague, Czechia' }
    rent { 1000 }
    author
  end
end
