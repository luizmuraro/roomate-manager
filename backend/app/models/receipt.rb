class Receipt < ApplicationRecord
  belongs_to :expense, optional: true  # Can be unlinked initially
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :image_validation

  enum :category, {
    groceries: 0,
    utilities: 1,
    household: 2,
    transport: 3,
    entertainment: 4,
    healthcare: 5,
    other: 6
  }

  enum :status, {
    unprocessed: 0,
    linked: 1,
    archived: 2
  }

  scope :recent, -> { order(created_at: :desc) }
  scope :unlinked, -> { where(expense: nil) }
  scope :by_category, ->(cat) { where(category: cat) }

  def category_emoji
    case category
    when 'groceries' then '🛒'
    when 'utilities' then '💡'
    when 'household' then '🏠'
    when 'transport' then '🚗'
    when 'entertainment' then '🎬'
    when 'healthcare' then '🏥'
    else '📄'
    end
  end

  def linked_to_expense?
    expense.present?
  end

  def brazilian_date
    created_at.strftime('%d/%m/%Y')
  end

  private

  def image_validation
    return unless image.attached?

    if image.byte_size > 10.megabytes
      errors.add(:image, 'must be less than 10MB')
    end

    unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/webp application/pdf])
      errors.add(:image, 'must be JPG, PNG, WebP, or PDF')
    end
  end
end
