class ExpensesController < ApplicationController

  def index
    puts '*******************************************************************************'
    p params[:type_id].to_i
    p params[:month]
    puts '*******************************************************************************'
    @tab = :expenses
    @types = Type.all
    @category = Category.all
    @dates = []
    Expense.all.each {|exp| @dates << Date.new(exp.date.year, exp.date.month, 1)}
    @months = @dates.uniq.sort.reverse
    @expenses = Expense.all.order('date DESC')

    if params[:month] == ""
      firstmonth_range = @months.last
      lastmonth_range = @months.first
      @currentmonth = "All Months"
    elsif !params[:month].present?
      firstmonth_range = Date.today
      lastmonth_range = Date.today
      @currentmonth = Date.today.strftime("%B %Y")
    elsif params[:month].present? && params[:month] != ""
      dateparams = params[:month].split("-")
      month = Date.new(dateparams[0].to_i, dateparams[1].to_i, 1)
      firstmonth_range = month
      lastmonth_range = month
      @currentmonth = month.strftime("%B %Y")
end


    if params[:type_id].present? && params[:category_id].present?
      p params
      @expenses = @expenses.where('type_id = ? AND category_id = ? AND date >= ? AND date <= ? ', params[:type_id], params[:category_id], firstmonth_range.at_beginning_of_month, lastmonth_range.at_end_of_month )
    elsif params[:category_id].present?
      @expenses = @expenses.where('category_id = ? AND date >= ? AND date <= ? ', params[:category_id],firstmonth_range.at_beginning_of_month, lastmonth_range.at_end_of_month)
    elsif params[:type_id].present?
      @expenses = @expenses.where('type_id = ? AND date >= ? AND date <= ? ', params[:type_id],firstmonth_range.at_beginning_of_month, lastmonth_range.at_end_of_month)
    else
      @expenses = @expenses.where('date >= ? AND date <= ? ', firstmonth_range.at_beginning_of_month, lastmonth_range.at_end_of_month)
    end
    @total = @expenses.sum(:amount)
    @average = if @expenses.count > 0
                 @total / @expenses.count
               else
                 0
               end
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.create(expense_params)
    @total = Expense.all.sum(:amount)
    @average = @total / Expense.all.count
    @transactions = Expense.all.count
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to expenses_path, notice: 'El producto fue eliminado con éxito'
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'El producto ha sido modificado con éxito'
    else
      render :edit
    end
  end

  private

  def expense_params
    params.require(:expense).permit!
  end
end
