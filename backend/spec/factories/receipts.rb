FactoryBot.define do
  factory :receipt do
    title { "Receipt for #{Faker::Commerce.product_name}" }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    expense { nil }
    user { association :user }
    category { Receipt.categories.keys.sample }
    status { :unprocessed }

    trait :linked do
      expense { association :expense }
      status { :linked }
    end

    trait :groceries do
      category { :groceries }
      title { "Compras no #{['Pão de Açúcar', 'Extra', 'Carrefour'].sample}" }
    end

    trait :utilities do
      category { :utilities }
      title { "Conta de #{['luz', 'água', 'gás'].sample}" }
    end

    trait :household do
      category { :household }
      title { "Produtos de #{['limpeza', 'casa', 'cuidados pessoais'].sample}" }
    end
  end
end
