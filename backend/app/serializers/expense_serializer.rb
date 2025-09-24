class ExpenseSerializer < ActiveModel::Serializer
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

  private

  def format_currency(amount)
    return { raw: 0.0, formatted: "R$ 0,00" } if amount.nil?

    {
      raw: amount.to_f,
      formatted: format_brazilian_currency(amount.to_f)
    }
  end

  def format_brazilian_currency(amount)
    # Converte para formato brasileiro: R$ 1.234,56
    formatted = sprintf("%.2f", amount)
    formatted = formatted.gsub('.', ',')  # Decimal vírgula

    # Adiciona pontos nos milhares
    integer_part, decimal_part = formatted.split(',')
    integer_part = integer_part.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse

    "R$ #{integer_part},#{decimal_part}"
  end
end