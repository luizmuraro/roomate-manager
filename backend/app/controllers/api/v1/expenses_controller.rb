class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :update, :destroy, :settle]

  def index
    @expenses = current_user.all_expenses.includes(:user, :roommate, :settled_by)

    # Filtros básicos
    @expenses = @expenses.where("description ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    @expenses = @expenses.where(category: params[:category]) if params[:category].present?
    @expenses = @expenses.where(status: params[:status]) if params[:status].present?

    # Quick filters
    @expenses = @expenses.where(user: current_user) if params[:paid_by] == 'you'
    @expenses = @expenses.where.not(user: current_user) if params[:paid_by] == 'roommate'
    @expenses = @expenses.where('amount > ?', 100) if params[:high_value] == 'true'

    # Date range filter
    if params[:date_from].present?
      @expenses = @expenses.where('created_at >= ?', Date.parse(params[:date_from]))
    end
    if params[:date_to].present?
      @expenses = @expenses.where('created_at <= ?', Date.parse(params[:date_to]))
    end

    # Ordenação
    case params[:sort_by]
    when 'amount_desc'
      @expenses = @expenses.order(amount: :desc)
    when 'amount_asc'
      @expenses = @expenses.order(amount: :asc)
    when 'date_desc'
      @expenses = @expenses.order(created_at: :desc)
    when 'date_asc'
      @expenses = @expenses.order(created_at: :asc)
    else
      @expenses = @expenses.recent
    end

    # Paginação
    page = params[:page] || 1
    per_page = [params[:per_page]&.to_i || 10, 100].min # Max 100 items per page
    @expenses = @expenses.page(page).per(per_page)

    render json: {
      expenses: @expenses.map { |expense| ExpenseSerializer.new(expense).as_json },
      pagination: {
        current_page: @expenses.current_page,
        per_page: @expenses.limit_value,
        total_pages: @expenses.total_pages,
        total_count: @expenses.total_count,
        next_page: @expenses.next_page,
        prev_page: @expenses.prev_page
      }
    }
  end

  def show
    render json: @expense, serializer: ExpenseSerializer
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      render json: @expense, serializer: ExpenseSerializer, status: :created
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      render json: @expense, serializer: ExpenseSerializer
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    head :no_content
  end

  def settle
    if @expense.mark_as_settled!(current_user)
      render json: @expense, serializer: ExpenseSerializer
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_expense
    @expense = current_user.all_expenses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Expense not found' }, status: :not_found
  end

  def expense_params
    params.require(:expense).permit(:amount, :description, :category, :roommate_id)
  end
end
