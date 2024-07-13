require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
  end

  test "user is logged in and redirected to home with correct credentials using 'remember me'" do
    cookies.delete(:app_session)
    assert_difference("@user.app_sessions.count", 1) {
      testing_log_in(@user, remember_me: true)
    }
    assert cookies[:app_session].present?
    assert_redirected_to root_path
  end

  test "user is logged in and redirected to home with correct credentials without 'remember me'" do
    cookies.delete(:app_session)
    assert_difference("@user.app_sessions.count", 1) {
      testing_log_in(@user)
    }
    assert_nil cookies[:app_session]
    assert_redirected_to root_path
  end

  test "error is rendered for login with incorrect credentials" do
    post login_path, params: {
      user: {
        email: "wrong@example.com",
        password: "password"
      }
    }
    assert_select ".msg-danger", I18n.t("sessions.create.incorrect_details")
  end

  test "logging out redirects to the root url and deletes the session" do
    testing_log_in(@user)
    assert_difference("@user.app_sessions.count", -1) { testing_log_out }
    assert_redirected_to root_path

    follow_redirect!
    assert_select ".msg-success",
      I18n.t("sessions.destroy.success")
  end
end
