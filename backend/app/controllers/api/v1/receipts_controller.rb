class Api::V1::ReceiptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_receipt, only: [:show, :update, :destroy, :link_to_expense]

  def index
    @receipts = current_user.receipts.includes(:expense)

    # Filtering
    @receipts = @receipts.where("title ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    @receipts = @receipts.where(category: params[:category]) if params[:category].present?
    @receipts = @receipts.where(status: params[:status]) if params[:status].present?
    @receipts = @receipts.unlinked if params[:unlinked] == 'true'

    # Date range filter
    if params[:date_from].present?
      @receipts = @receipts.where('created_at >= ?', Date.parse(params[:date_from]))
    end
    if params[:date_to].present?
      @receipts = @receipts.where('created_at <= ?', Date.parse(params[:date_to]))
    end

    # Sorting
    case params[:sort_by]
    when 'amount_desc'
      @receipts = @receipts.order(amount: :desc)
    when 'amount_asc'
      @receipts = @receipts.order(amount: :asc)
    when 'date_desc'
      @receipts = @receipts.order(created_at: :desc)
    when 'date_asc'
      @receipts = @receipts.order(created_at: :asc)
    else
      @receipts = @receipts.recent
    end

    # Pagination - Receipts can be many, smaller pagination for performance
    page = params[:page] || 1
    per_page = [params[:per_page]&.to_i || 12, 100].min # Default 12 items (grid layout)
    @receipts = @receipts.page(page).per(per_page)

    render json: {
      receipts: @receipts.map { |receipt| ReceiptSerializer.new(receipt).as_json },
      pagination: {
        current_page: @receipts.current_page,
        per_page: @receipts.limit_value,
        total_pages: @receipts.total_pages,
        total_count: @receipts.total_count,
        next_page: @receipts.next_page,
        prev_page: @receipts.prev_page
      }
    }
  end

  def show
    render json: @receipt, serializer: ReceiptSerializer
  end

  def create
    @receipt = current_user.receipts.build(receipt_params)

    if @receipt.save
      render json: @receipt, serializer: ReceiptSerializer, status: :created
    else
      render json: { errors: @receipt.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @receipt.update(receipt_params)
      render json: @receipt, serializer: ReceiptSerializer
    else
      render json: { errors: @receipt.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @receipt.destroy
    head :no_content
  end

  def link_to_expense
    expense = current_user.all_expenses.find(params[:expense_id])

    if @receipt.update(expense: expense, status: :linked)
      render json: @receipt, serializer: ReceiptSerializer
    else
      render json: { errors: @receipt.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Expense not found' }, status: :not_found
  end

  def stats
    receipts = current_user.receipts

    stats = {
      total_count: receipts.count,
      total_amount: receipts.sum(:amount),
      unlinked_count: receipts.unlinked.count,
      linked_count: receipts.where.not(expense: nil).count,
      categories: Receipt.categories.keys.map do |category|
        {
          name: category,
          count: receipts.where(category: category).count,
          total_amount: receipts.where(category: category).sum(:amount),
          emoji: Receipt.new(category: category).category_emoji
        }
      end
    }

    render json: stats
  end

  private

  def set_receipt
    @receipt = current_user.receipts.find(params[:id])
  end

  def receipt_params
    params.require(:receipt).permit(:title, :amount, :category, :image, :expense_id)
  end
end
