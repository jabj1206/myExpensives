class ChartsController < ApplicationController
  def semester_type
    @semester_type = []
    Type.all.each do |type|
      @semester_type << { name: type.name, data: Expense.where("date >= ? AND date <= ? AND type_id = #{type.id}", 6.months.ago.at_beginning_of_month, Date.today.at_end_of_month).group_by_month(:date, format: '%m %y').sum(:amount) }
    end
    render json: @semester_type
end

  def type
    @type = []
    Type.all.each do |type|
      @type << { name: type.name, data: Expense.where("date >= ? AND date <= ? AND type_id = #{type.id}", Date.today.at_beginning_of_month, Date.today.at_end_of_month).group_by_day_of_month(:date).sum(:amount) }
    end
    render json: @type
  end

  def category
    @category = {}
    Category.all.each do |category|
      @category[category.name] = Expense.where("date >= ? AND date <= ? AND category_id = #{category.id}", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)
    end
    puts '*********************************************************************************'
    puts @category
    puts '*********************************************************************************'
    render json: @category
  end

  def accumulated
    lastmonthexpaccumulated = {}
    lastmonthallexp = 0
    eachdaylastmonthexp = Expense.where('date >= ? AND date <= ?', Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).group_by_day_of_month(:date).sum(:amount)

    eachdaylastmonthexp.each do |day, exp|
      lastmonthallexp += exp
      lastmonthexpaccumulated[day] = lastmonthallexp
    end

    thismonthexpaccumulated = {}
    thismonthallexp = 0
    eachdaythismonthexp = Expense.where('date >= ? AND date <= ?', Date.today.at_beginning_of_month, Date.today.at_end_of_month).group_by_day_of_month(:date).sum(:amount)
    eachdaythismonthexp.each do |day, exp|
      thismonthallexp += exp
      thismonthexpaccumulated[day] = thismonthallexp
    end

    @twomonthsaccumulated = [{ name: 'This Month', data: thismonthexpaccumulated }, { name: 'Last Month', data: lastmonthexpaccumulated }]

    render json: @twomonthsaccumulated
  end
end
