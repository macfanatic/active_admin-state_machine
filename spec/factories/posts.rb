FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { 'lorem ipsum' }
    category

    status { :draft }

    trait :reviewed do
      status { :reviewed }
    end
  end
end
