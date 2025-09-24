FactoryBot.define do
  factory :shopping_item do
    name { "MyString" }
    category { 1 }
    completed { false }
    user { nil }
    roommate { nil }
  end
end
