require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should show expenses index" do
    get expenses_url
    assert_response :success
  end
end
