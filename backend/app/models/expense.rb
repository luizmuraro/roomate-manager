class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :roommate, class_name: 'User'
  belongs_to :settled_by, class_name: 'User', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 3 }

  enum :status, { pending: 0, settled: 1 }
  enum :category, { groceries: 0, utilities: 1, household: 2, pantry: 3, other: 4 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }

  def split_amount
    amount / 2.0
  end

  def mark_as_settled!(user)
    update!(
      status: :settled,
      settled_at: Time.current,
      settled_by: user
    )
  end
end
