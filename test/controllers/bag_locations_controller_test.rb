require "test_helper"

class BagLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bag_location = bag_locations(:one)
  end

  test "should get index" do
    get bag_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_bag_location_url
    assert_response :success
  end

  test "should create bag_location" do
    assert_difference('BagLocation.count') do
      post bag_locations_url, params: { bag_location: { customer_id: @bag_location.customer_id, event_id: @bag_location.event_id, location: @bag_location.location } }
    end

    assert_redirected_to bag_location_url(BagLocation.last)
  end

  test "should show bag_location" do
    get bag_location_url(@bag_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_bag_location_url(@bag_location)
    assert_response :success
  end

  test "should update bag_location" do
    patch bag_location_url(@bag_location), params: { bag_location: { customer_id: @bag_location.customer_id, event_id: @bag_location.event_id, location: @bag_location.location } }
    assert_redirected_to bag_location_url(@bag_location)
  end

  test "should destroy bag_location" do
    assert_difference('BagLocation.count', -1) do
      delete bag_location_url(@bag_location)
    end

    assert_redirected_to bag_locations_url
  end
end
