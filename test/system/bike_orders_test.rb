require "application_system_test_case"

class BikeOrdersTest < ApplicationSystemTestCase
  setup do
    @bike_order = bike_orders(:one)
  end

  test "visiting the index" do
    visit bike_orders_url
    assert_selector "h1", text: "Bike orders"
  end

  test "should create bike order" do
    visit bike_orders_url
    click_on "New bike order"

    click_on "Create Bike order"

    assert_text "Bike order was successfully created"
    click_on "Back"
  end

  test "should update Bike order" do
    visit bike_order_url(@bike_order)
    click_on "Edit this bike order", match: :first

    click_on "Update Bike order"

    assert_text "Bike order was successfully updated"
    click_on "Back"
  end

  test "should destroy Bike order" do
    visit bike_order_url(@bike_order)
    click_on "Destroy this bike order", match: :first

    assert_text "Bike order was successfully destroyed"
  end
end
