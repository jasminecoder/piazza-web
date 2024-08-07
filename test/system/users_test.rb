require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "new user can sign up" do 
    visit root_path

    click_on I18n.t("application.navbar.sign_up")

    fill_in User.human_attribute_name(:name), with: "Newman"
    fill_in User.human_attribute_name(:email), with: "newman@example.com"
    fill_in User.human_attribute_name(:password), with: "short"
    fill_in User.human_attribute_name(:password_confirmation), with: "short"

    click_on I18n.t("users.new.sign_up")
    assert_current_path sign_up_path
    assert_selector "span.text-red-500", text: I18n.t("activerecord.errors.models.user.attributes.password.too_short")

    fill_in User.human_attribute_name(:password), with: "password"
    fill_in User.human_attribute_name(:password_confirmation), with: "password"
    click_on I18n.t("users.new.sign_up")

    # puts save_and_open_page
    # puts page.body
    # sleep 1; puts current_path

    assert_current_path root_path
    assert_selector ".msg-success", text: I18n.t("users.create.welcome", name: "Newman") 
    assert_selector ".dropdown", visible: false
  end

  test "existing user can login" do 
    visit root_path

    click_on I18n.t("application.navbar.login")
    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "wrong"
    
    click_button I18n.t("sessions.new.submit")
    assert_selector ".msg-error", text: I18n.t("sessions.create.incorrect_details")

    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "password"
    click_button I18n.t("sessions.new.submit")

    assert_current_path root_path
    assert_selector ".msg-success", text: I18n.t("sessions.create.success", name: "Jerry") 
    assert_selector ".dropdown", visible: false
  end

  test "can update name" do 
    log_in(users(:jerry))

    visit profile_path 
    
    fill_in User.human_attribute_name(:name), with: "Jerry Seinfeld"
    click_button I18n.t("users.show.save_profile")

    assert_selector "form .msg-success", text: I18n.t("users.update.success")
    assert_selector "#current_user_name", text: "Jerry Seinfeld"
    
  end
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end
end
