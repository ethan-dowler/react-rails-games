class LoginController < AuthController
  skip_before_action :authenticate_request!
  before_action :ensure_user_not_logged_in, only: :index

  def index; end

  def create
    user = User.find_by(email: params[:email])

    if user.valid_password?(params[:password])
      cookies["auth_token"] = JsonWebToken.encode({ user_id: user.id })
      flash.notice = "Login Successful!"
      redirect_to root_path
    else
      flash.error = "Invalid Username/Password combo"
      redirect_to login_index_path, status: :unauthorized
    end
  end

private

  def ensure_user_not_logged_in
    return unless user_id_in_cookie?

    flash.notice = "You are already logged in."

    redirect_to root_path
  end
end
