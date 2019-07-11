
class DashboardController < ApplicationController
  def index
    @tab = :dashboard
    @expensetoday = Expense.where("date = ?", Date.today).sum(:amount) 
    @expenseyesterday = Expense.where("date = ?", Date.today.yesterday).sum(:amount) 
    @expensethismonth = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month,Date.today.at_end_of_month).sum(:amount)
    @expenselastmonth = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).sum(:amount)
    
  end
end
