FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentence 5 }
    author
  end

  factory :post_comment, class: "Comment" do
    association :commentable, factory: :post
    content { Faker::Lorem.sentence 5 }
    author
  end

  factory :tag_comment, class: "Comment" do
    association :commentable, factory: :tag
    content { Faker::Lorem.sentence 5 }
    author
  end
end