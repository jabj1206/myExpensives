require 'test_helper'

class ExpenseFlowTest < ActionDispatch::IntegrationTest
    include ActiveJob::TestHelper
    setup do
        Capybara.default_driver = :selenium_chrome
    end

    test "create a new expense from js" do
        visit expenses_path
        click_link "New Expense"
        fill_in "expense_amount", with: "30"
        fill_in "expense_concept", with: "Example-PI"
        click_button "Create Expense"

        assert_current_path expenses_path
        assert page.has_content?('Example-PI')
        assert page.has_content?("30")
        assert_equal(Expense.last.concept, "Example-PI")
        assert_equal(Expense.last.date, Date.today)
        assert_equal(Expense.last.amount, 30)
    end

    test "show all months" do
        visit "/expenses?month="
        assert page.has_content?("All Months")
        assert page.has_content?("Test1")
        assert page.has_content?("Test2")
    end
    
    test "show typ1 only" do
        visit "/expenses?month=&type=1"
        assert page.has_content?("Test1")
    end
    
    test "show cat2 only" do      
        visit "/expenses?month=&category=2"
        assert page.has_content?("Test2")
    end

    end