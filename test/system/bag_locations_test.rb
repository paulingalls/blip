require "application_system_test_case"

class BagLocationsTest < ApplicationSystemTestCase
  setup do
    @bag_location = bag_locations(:one)
  end

  test "visiting the index" do
    visit bag_locations_url
    assert_selector "h1", text: "Bag Locations"
  end

  test "creating a Bag location" do
    visit bag_locations_url
    click_on "New Bag Location"

    fill_in "Customer", with: @bag_location.customer_id
    fill_in "Event", with: @bag_location.event_id
    fill_in "Location", with: @bag_location.location
    click_on "Create Bag location"

    assert_text "Bag location was successfully created"
    click_on "Back"
  end

  test "updating a Bag location" do
    visit bag_locations_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @bag_location.customer_id
    fill_in "Event", with: @bag_location.event_id
    fill_in "Location", with: @bag_location.location
    click_on "Update Bag location"

    assert_text "Bag location was successfully updated"
    click_on "Back"
  end

  test "destroying a Bag location" do
    visit bag_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bag location was successfully destroyed"
  end
end
