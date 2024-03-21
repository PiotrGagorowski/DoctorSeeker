require "application_system_test_case"

class UserAppointmentsTest < ApplicationSystemTestCase
  setup do
    @user_appointment = user_appointments(:one)
  end

  test "visiting the index" do
    visit user_appointments_url
    assert_selector "h1", text: "User appointments"
  end

  test "should create user appointment" do
    visit user_appointments_url
    click_on "New user appointment"

    fill_in "Appointment", with: @user_appointment.appointment_id
    fill_in "Doctor user", with: @user_appointment.doctor_user_id
    fill_in "Patient user", with: @user_appointment.patient_user_id
    click_on "Create User appointment"

    assert_text "User appointment was successfully created"
    click_on "Back"
  end

  test "should update User appointment" do
    visit user_appointment_url(@user_appointment)
    click_on "Edit this user appointment", match: :first

    fill_in "Appointment", with: @user_appointment.appointment_id
    fill_in "Doctor user", with: @user_appointment.doctor_user_id
    fill_in "Patient user", with: @user_appointment.patient_user_id
    click_on "Update User appointment"

    assert_text "User appointment was successfully updated"
    click_on "Back"
  end

  test "should destroy User appointment" do
    visit user_appointment_url(@user_appointment)
    click_on "Destroy this user appointment", match: :first

    assert_text "User appointment was successfully destroyed"
  end
end
