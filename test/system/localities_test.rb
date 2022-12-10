require "application_system_test_case"

class LocalitiesTest < ApplicationSystemTestCase
  setup do
    @locality = localities(:one)
  end

  test "visiting the index" do
    visit localities_url
    assert_selector "h1", text: "Localities"
  end

  test "should create locality" do
    visit localities_url
    click_on "New locality"

    fill_in "Locality", with: @locality.locality
    fill_in "Province", with: @locality.province
    click_on "Create Locality"

    assert_text "Locality was successfully created"
    click_on "Back"
  end

  test "should update Locality" do
    visit locality_url(@locality)
    click_on "Edit this locality", match: :first

    fill_in "Locality", with: @locality.locality
    fill_in "Province", with: @locality.province
    click_on "Update Locality"

    assert_text "Locality was successfully updated"
    click_on "Back"
  end

  test "should destroy Locality" do
    visit locality_url(@locality)
    click_on "Destroy this locality", match: :first

    assert_text "Locality was successfully destroyed"
  end
end
