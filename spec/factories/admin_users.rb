FactoryGirl.define do
  factory :user, class: "AdminUser" do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "Password1"
    password_confirmation "Password1"

    factory :admin_user do
      after(:build) do |user|
        user.stub(:super_admin?) { true }
      end
    end
  end
end
