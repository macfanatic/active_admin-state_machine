FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body "lorem ipsum"
    category

    trait :reviewed do
      status Post::REVIEWED
    end
  end
end
