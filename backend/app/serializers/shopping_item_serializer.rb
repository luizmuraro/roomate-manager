class ShoppingItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :category_display, :category_emoji,
             :completed, :date, :added_by

  belongs_to :user, serializer: UserSerializer
  belongs_to :roommate, serializer: UserSerializer

  def category_display
    I18n.t("shopping_item.categories.#{object.category}", default: object.category.humanize)
  end

  def category_emoji
    object.category_emoji
  end

  def date
    object.created_at.strftime('%d/%m/%Y')
  end

  def added_by
    {
      id: object.user.id,
      name: object.user.name,
      is_you: object.user == current_user
    }
  end

  private

  def current_user
    @instance_options[:scope]
  end
end