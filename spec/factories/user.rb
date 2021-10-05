FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "ololo_#{n}@example.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456"}
  end
end
