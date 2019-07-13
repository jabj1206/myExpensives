module Api
  module V1
    class ExpensesController < ApplicationController
      before_action :set_expense, only: %i[show edit update destroy]
      def index
        @expenses = Expense.all
        render json: @expenses
        end

      def new
        @expense = Expense.new
        end

      def create
        expense = Expense.new(expense_params)
        if expense.save
          render json: expense
        else
          render json: { errors: expense.errors }, status: 422
        end
        end

      def update
        @expense = Expense.find(params[:id])
        if @expense.update(expense_params)
          render json: @expense
        else
          render json: { errors: @expense.errors }, status: 422
        end
      end

      def destroy
        @expense.destroy

        render json: @expenses, status: 204
      end

      private

      def expense_params
        params.require(:expense).permit!
      end

      def set_expense
        @expense = Expense.find(params[:id])
      end
    end
  end
end
