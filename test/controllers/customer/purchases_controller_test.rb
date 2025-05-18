require "test_helper"

class Customer::PurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_purchases_index_url
    assert_response :success
  end

  test "should get show" do
    get customer_purchases_show_url
    assert_response :success
  end
end
