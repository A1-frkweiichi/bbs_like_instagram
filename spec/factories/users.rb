FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name { "テストユーザー" }
    password { "password" }
    password_confirmation { "password" }
    provider { "google_oauth2" }
    uid { "123456789" }
  end
end
