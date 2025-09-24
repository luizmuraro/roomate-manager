class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :update, :destroy, :settle]

  def index
    @expenses = current_user.all_expenses.includes(:user, :roommate, :settled_by).recent
    render json: @expenses, each_serializer: ExpenseSerializer
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
