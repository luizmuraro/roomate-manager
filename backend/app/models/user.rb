class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  # Expenses relationships
  has_many :expenses, dependent: :destroy
  has_many :roommate_expenses, class_name: 'Expense', foreign_key: 'roommate_id', dependent: :destroy
  has_many :settled_expenses, class_name: 'Expense', foreign_key: 'settled_by_id', dependent: :nullify

  # Shopping items relationships
  has_many :shopping_items, dependent: :destroy
  has_many :roommate_shopping_items, class_name: 'ShoppingItem', foreign_key: 'roommate_id', dependent: :destroy

  # Receipts relationships
  has_many :receipts, dependent: :destroy

  def full_name
    name
  end

  def all_expenses
    Expense.where('user_id = ? OR roommate_id = ?', id, id)
  end

  def pending_expenses
    all_expenses.pending
  end

  def balance_with_roommate(roommate)
    # Calculate what this user owes to roommate
    owed_to_roommate = roommate.expenses.where(roommate: self).pending.sum(&:split_amount)
    # Calculate what roommate owes to this user
    owed_from_roommate = expenses.where(roommate: roommate).pending.sum(&:split_amount)

    owed_from_roommate - owed_to_roommate
  end
end
