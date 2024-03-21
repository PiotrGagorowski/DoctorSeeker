require "application_system_test_case"

class UserReviewsTest < ApplicationSystemTestCase
  setup do
    @user_review = user_reviews(:one)
  end

  test "visiting the index" do
    visit user_reviews_url
    assert_selector "h1", text: "User reviews"
  end

  test "should create user review" do
    visit user_reviews_url
    click_on "New user review"

    fill_in "Doctor user", with: @user_review.doctor_user_id
    fill_in "Patient user", with: @user_review.patient_user_id
    fill_in "Review", with: @user_review.review_id
    click_on "Create User review"

    assert_text "User review was successfully created"
    click_on "Back"
  end

  test "should update User review" do
    visit user_review_url(@user_review)
    click_on "Edit this user review", match: :first

    fill_in "Doctor user", with: @user_review.doctor_user_id
    fill_in "Patient user", with: @user_review.patient_user_id
    fill_in "Review", with: @user_review.review_id
    click_on "Update User review"

    assert_text "User review was successfully updated"
    click_on "Back"
  end

  test "should destroy User review" do
    visit user_review_url(@user_review)
    click_on "Destroy this user review", match: :first

    assert_text "User review was successfully destroyed"
  end
end
