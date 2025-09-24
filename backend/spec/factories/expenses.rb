FactoryBot.define do
  factory :expense do
    amount { "9.99" }
    description { "MyString" }
    category { 1 }
    status { 1 }
    user { nil }
    roommate { nil }
    settled_at { "2025-09-24 13:21:30" }
    settled_by { nil }
  end
end
