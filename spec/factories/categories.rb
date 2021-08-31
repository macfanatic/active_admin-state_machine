FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }

    transient do
      num_posts { 0 }
    end

    after(:create) do |category, evaluator|
      if evaluator.num_posts > 0
        evaluator.num_posts.times do
          create(:post, category: category)
        end
      end
    end
  end
end
