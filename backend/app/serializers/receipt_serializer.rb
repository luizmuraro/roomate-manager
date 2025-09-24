class ReceiptSerializer < ActiveModel::Serializer
  include CurrencyFormatting

  attributes :id, :title, :amount, :category, :category_display, :category_emoji,
             :status, :status_display, :date, :linked_to_expense, :image_url

  belongs_to :expense, serializer: ExpenseSerializer, if: :linked_to_expense?
  belongs_to :user, serializer: UserSerializer

  def amount
    format_currency(object.amount)
  end

  def category_display
    object.category.humanize
  end

  def category_emoji
    object.category_emoji
  end

  def status_display
    case object.status
    when 'unprocessed'
      'Não processado'
    when 'linked'
      'Vinculado'
    when 'archived'
      'Arquivado'
    else
      object.status.humanize
    end
  end

  def date
    object.brazilian_date
  end

  def linked_to_expense
    object.linked_to_expense?
  end

  def linked_to_expense?
    object.linked_to_expense?
  end

  def image_url
    # TODO: Implement Active Storage support when needed
    nil
  end
end