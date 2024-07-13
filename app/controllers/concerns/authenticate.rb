module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
    before_action :require_login, unless: :logged_in?

    helper_method :logged_in?
  end

  class_methods do
    def skip_authentication(**options)
      skip_before_action :authenticate, options
      skip_before_action :require_login, options
    end

    def allow_unauthenticated(**options)
      skip_before_action :require_login, options
    end
  end

  protected

  def logged_in?
    Current.user.present?
  end

  def log_in(app_session, remember_me_checked)
    set_app_session_summary(app_session, remember_me_checked)
  end

  def log_out
    Current.app_session&.destroy
    clear_app_session_summary
  end

  private

  def require_login
    flash.now[:notice] = t("login_required")
    render "sessions/new", status: :unauthorized
  end

  def authenticate
    Current.app_session = get_app_session
    Current.user = Current.app_session&.user
  end

  def get_app_session
    user_id, app_session_id, token = get_app_session_summary.values_at(:user_id, :app_session_id, :token)
    return nil if user_id.blank? || app_session_id.blank? || token.blank?
    user = User.find_by(id: user_id)
    return nil if user.blank?
    user.authenticate_app_session(app_session_id, token)
  end

  def get_app_session_summary
    (cookies.encrypted[:app_session] || session[:app_session])&.with_indifferent_access || {}
  end

  def set_app_session_summary(app_session, remember_me_checked)
    clear_app_session_summary
    if remember_me_checked
      cookies.encrypted.permanent[:app_session] = {value: app_session.to_h}
    else
      session[:app_session] = app_session.to_h
    end
  end

  def clear_app_session_summary
    # cookies.encrypted.permanent[:app_session] = nil
    cookies.delete(:app_session)
    session.delete(:app_session)
  end
end
