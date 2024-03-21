require "test_helper"

class UserAppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_appointment = user_appointments(:one)
  end

  test "should get index" do
    get user_appointments_url
    assert_response :success
  end

  test "should get new" do
    get new_user_appointment_url
    assert_response :success
  end

  test "should create user_appointment" do
    assert_difference("UserAppointment.count") do
      post user_appointments_url, params: { user_appointment: { appointment_id: @user_appointment.appointment_id, doctor_user_id: @user_appointment.doctor_user_id, patient_user_id: @user_appointment.patient_user_id } }
    end

    assert_redirected_to user_appointment_url(UserAppointment.last)
  end

  test "should show user_appointment" do
    get user_appointment_url(@user_appointment)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_appointment_url(@user_appointment)
    assert_response :success
  end

  test "should update user_appointment" do
    patch user_appointment_url(@user_appointment), params: { user_appointment: { appointment_id: @user_appointment.appointment_id, doctor_user_id: @user_appointment.doctor_user_id, patient_user_id: @user_appointment.patient_user_id } }
    assert_redirected_to user_appointment_url(@user_appointment)
  end

  test "should destroy user_appointment" do
    assert_difference("UserAppointment.count", -1) do
      delete user_appointment_url(@user_appointment)
    end

    assert_redirected_to user_appointments_url
  end
end
