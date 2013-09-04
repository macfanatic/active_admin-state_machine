FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body "lorem ipsum"
    category
  end
end
