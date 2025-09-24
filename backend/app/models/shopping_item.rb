class ShoppingItem < ApplicationRecord
  belongs_to :user
  belongs_to :roommate, class_name: 'User'

  validates :name, presence: true, length: { minimum: 2 }

  enum :category, { produce: 0, dairy: 1, meat: 2, household: 3, pantry: 4, other: 5 }

  scope :pending, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :recent, -> { order(created_at: :desc) }

  def toggle_completion!
    update!(completed: !completed)
  end

  def category_emoji
    case category
    when 'produce' then '🥬'
    when 'dairy' then '🥛'
    when 'meat' then '🍖'
    when 'household' then '🧹'
    when 'pantry' then '📦'
    else '📦'
    end
  end
end
