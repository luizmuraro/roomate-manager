class Api::V1::ShoppingItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_item, only: [:show, :update, :destroy, :toggle]

  def index
    @items = current_user.shopping_items
      .includes(:user, :roommate)
      .recent

    # Filtros
    @items = @items.where(completed: params[:completed]) if params[:completed].present?
    @items = @items.where(category: params[:category]) if params[:category].present?

    render json: @items, each_serializer: ShoppingItemSerializer
  end

  def show
    render json: @shopping_item, serializer: ShoppingItemSerializer
  end

  def create
    @shopping_item = current_user.shopping_items.build(shopping_item_params)

    if @shopping_item.save
      render json: @shopping_item, serializer: ShoppingItemSerializer, status: :created
    else
      render json: { errors: @shopping_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @shopping_item.update(shopping_item_params)
      render json: @shopping_item, serializer: ShoppingItemSerializer
    else
      render json: { errors: @shopping_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @shopping_item.destroy
    head :no_content
  end

  def toggle
    @shopping_item.toggle_completion!
    render json: @shopping_item, serializer: ShoppingItemSerializer
  end

  # Bulk operations
  def clear_completed
    current_user.shopping_items.completed.destroy_all
    head :no_content
  end

  def stats
    stats = {
      total: current_user.shopping_items.count,
      pending: current_user.shopping_items.pending.count,
      completed: current_user.shopping_items.completed.count
    }
    render json: stats
  end

  private

  def set_shopping_item
    @shopping_item = current_user.shopping_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Shopping item not found' }, status: :not_found
  end

  def shopping_item_params
    params.require(:shopping_item).permit(:name, :category, :roommate_id)
  end
end
