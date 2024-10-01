require "test_helper"

class BikeOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bike_order = bike_orders(:one)
  end

  test "should get index" do
    get bike_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_bike_order_url
    assert_response :success
  end

  test "should create bike_order" do
    assert_difference("BikeOrder.count") do
      post bike_orders_url, params: { bike_order: {} }
    end

    assert_redirected_to bike_order_url(BikeOrder.last)
  end

  test "should show bike_order" do
    get bike_order_url(@bike_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_bike_order_url(@bike_order)
    assert_response :success
  end

  test "should update bike_order" do
    patch bike_order_url(@bike_order), params: { bike_order: {} }
    assert_redirected_to bike_order_url(@bike_order)
  end

  test "should destroy bike_order" do
    assert_difference("BikeOrder.count", -1) do
      delete bike_order_url(@bike_order)
    end

    assert_redirected_to bike_orders_url
  end
end
