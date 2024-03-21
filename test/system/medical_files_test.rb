require "application_system_test_case"

class MedicalFilesTest < ApplicationSystemTestCase
  setup do
    @medical_file = medical_files(:one)
  end

  test "visiting the index" do
    visit medical_files_url
    assert_selector "h1", text: "Medical files"
  end

  test "should create medical file" do
    visit medical_files_url
    click_on "New medical file"

    fill_in "Type", with: @medical_file.type
    fill_in "User", with: @medical_file.user_id
    click_on "Create Medical file"

    assert_text "Medical file was successfully created"
    click_on "Back"
  end

  test "should update Medical file" do
    visit medical_file_url(@medical_file)
    click_on "Edit this medical file", match: :first

    fill_in "Type", with: @medical_file.type
    fill_in "User", with: @medical_file.user_id
    click_on "Update Medical file"

    assert_text "Medical file was successfully updated"
    click_on "Back"
  end

  test "should destroy Medical file" do
    visit medical_file_url(@medical_file)
    click_on "Destroy this medical file", match: :first

    assert_text "Medical file was successfully destroyed"
  end
end
