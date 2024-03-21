require "test_helper"

class MedicalFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medical_file = medical_files(:one)
  end

  test "should get index" do
    get medical_files_url
    assert_response :success
  end

  test "should get new" do
    get new_medical_file_url
    assert_response :success
  end

  test "should create medical_file" do
    assert_difference("MedicalFile.count") do
      post medical_files_url, params: { medical_file: { type: @medical_file.type, user_id: @medical_file.user_id } }
    end

    assert_redirected_to medical_file_url(MedicalFile.last)
  end

  test "should show medical_file" do
    get medical_file_url(@medical_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_medical_file_url(@medical_file)
    assert_response :success
  end

  test "should update medical_file" do
    patch medical_file_url(@medical_file), params: { medical_file: { type: @medical_file.type, user_id: @medical_file.user_id } }
    assert_redirected_to medical_file_url(@medical_file)
  end

  test "should destroy medical_file" do
    assert_difference("MedicalFile.count", -1) do
      delete medical_file_url(@medical_file)
    end

    assert_redirected_to medical_files_url
  end
end
