# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Criando dados de teste..."

# Limpar dados existentes
User.destroy_all
Expense.destroy_all
ShoppingItem.destroy_all

# Criar usuários (companheiros de quarto)
joão = User.create!(
  name: "João Silva",
  email: "joao@roommate.com",
  password: "123456",
  password_confirmation: "123456"
)

maria = User.create!(
  name: "Maria Santos",
  email: "maria@roommate.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "✅ Usuários criados: #{User.count}"

# Criar despesas de exemplo
expenses_data = [
  {
    description: "Compras no supermercado",
    amount: 127.80,
    category: :groceries,
    user: joão,
    roommate: maria
  },
  {
    description: "Conta de luz",
    amount: 89.50,
    category: :utilities,
    user: maria,
    roommate: joão
  },
  {
    description: "Produtos de limpeza",
    amount: 45.30,
    category: :household,
    user: joão,
    roommate: maria
  },
  {
    description: "Gás de cozinha",
    amount: 95.00,
    category: :utilities,
    user: maria,
    roommate: joão,
    status: :settled,
    settled_at: 2.days.ago,
    settled_by: joão
  }
]

expenses_data.each do |expense_attrs|
  expense = Expense.create!(expense_attrs)
  puts "💰 Criada despesa: #{expense.description} - #{expense.amount}"
end

puts "✅ Despesas criadas: #{Expense.count}"

# Criar itens de lista de compras
shopping_items_data = [
  {
    name: "Leite integral 1L",
    category: :dairy,
    user: joão,
    roommate: maria
  },
  {
    name: "Bananas orgânicas",
    category: :produce,
    user: maria,
    roommate: joão
  },
  {
    name: "Peito de frango 1kg",
    category: :meat,
    user: joão,
    roommate: maria
  },
  {
    name: "Detergente líquido",
    category: :household,
    user: maria,
    roommate: joão,
    completed: true
  },
  {
    name: "Arroz tipo 1 - 5kg",
    category: :pantry,
    user: joão,
    roommate: maria
  }
]

shopping_items_data.each do |item_attrs|
  item = ShoppingItem.create!(item_attrs)
  status = item.completed? ? "✅" : "⏳"
  puts "🛒 #{status} Item criado: #{item.name} (#{item.category_emoji})"
end

puts "✅ Lista de compras criada: #{ShoppingItem.count} itens"
puts ""
puts "🎉 Seed finalizado!"
puts "👥 Usuários: #{User.count}"
puts "💰 Despesas: #{Expense.count}"
puts "🛒 Itens de compras: #{ShoppingItem.count}"
puts ""
puts "🔑 Login de teste:"
puts "   Email: joao@roommate.com"
puts "   Senha: 123456"
puts ""
puts "   Email: maria@roommate.com"
puts "   Senha: 123456"