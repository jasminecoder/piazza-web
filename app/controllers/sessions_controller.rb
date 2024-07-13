class SessionsController < ApplicationController
  skip_authentication only: [:new, :create]
  def new
  end

  def create
    @app_session = User.create_app_session(
      email: login_params[:email],
      password: login_params[:password]
    )
    Rails.logger.info("@APP_SESSION #{@app_session}")
    unless @app_session
      flash.now[:danger] = t(".incorrect_details")
      render :new, status: :unprocessable_entity
      return
    end

    log_in(@app_session, remember_me_checked?)
    flash[:success] = t(".success", name: @app_session.user.name)
    redirect_to root_path, status: :see_other
  end

  def destroy
    log_out

    flash[:success] = t(".success")
    redirect_to root_path, status: :see_other
  end

  private

  def login_params
    @login_params ||= params.require(:user).permit(:email, :password, :remember_me)
  end

  def remember_me_checked?
    login_params[:remember_me] == "1"
  end
end
