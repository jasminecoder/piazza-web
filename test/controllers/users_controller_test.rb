require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "redirects to feed after successful sign up" do
    get sign_up_path
    assert_response :ok

    assert_difference ["User.count", "Organization.count"], 1 do
      post sign_up_path, params: {
        user: {
          name: "John",
          email: "johndoe@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_select ".msg-success",
      text: I18n.t("users.create.welcome", name: "John")
  end

  test "renders errors if input data is invalid" do
    get sign_up_path
    assert_response :ok

    assert_no_difference ["User.count", "Organization.count"] do
      post sign_up_path, params: {
        user: {
          name: "John",
          email: "johndoe@example.com",
          password: "pass",
          password_confirmation: "pass"
        }
      }
    end
  end

  test "can update user details" do 
    @user = users(:jerry)
    testing_log_in @user
    
    patch profile_path, params: {
            user: {
              name: "Jerry Seinfeld"
            }
    }
    
    assert_redirected_to profile_path
    assert_equal "Jerry Seinfeld", @user.reload.name 
  end
  # assert_response :unprocessable_entity
  # assert_select "p.is-danger",
  # text:
  # I18n.t("activerecord.errors.models.user.attributes.password.too_short")
  # end
end
