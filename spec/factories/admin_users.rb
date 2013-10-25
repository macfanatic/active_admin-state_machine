FactoryGirl.define do
  factory :user, class: "AdminUser" do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "Password1"
    password_confirmation "Password1"
    super_admin false
  end
end
