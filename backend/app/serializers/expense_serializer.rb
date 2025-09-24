class ExpenseSerializer < ActiveModel::Serializer
  include CurrencyFormatting

  attributes :id, :description, :amount, :your_share, :category, :category_display,
             :status, :status_display, :date, :settled_at, :settled_by

  belongs_to :user, serializer: UserSerializer
  belongs_to :roommate, serializer: UserSerializer

  def amount
    format_currency(object.amount)
  end

  def your_share
    format_currency(object.split_amount)
  end

  def category_display
    I18n.t("expense.categories.#{object.category}", default: object.category.humanize)
  end

  def status_display
    I18n.t("expense.status.#{object.status}", default: object.status.humanize)
  end

  def date
    object.created_at.strftime('%d/%m/%Y')
  end

  def settled_at
    return nil unless object.settled_at
    object.settled_at.strftime('%d/%m/%Y %H:%M')
  end

  def settled_by
    return nil unless object.settled_by
    {
      id: object.settled_by.id,
      name: object.settled_by.name
    }
  end

end