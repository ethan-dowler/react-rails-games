class AuthController < ApplicationController
  attr_reader :current_user

  before_action :authenticate_request!

protected

  def authenticate_request!
    redirect_to login_index_path and return unlessuser_id_in_cookie?

    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    redirect_to login_index_path
  end

private

  def auth_cookie
    @auth_cookie ||= cookies["auth_token"]
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(auth_cookie)
  end

  def user_id_in_cookie?
    auth_cookie.present? && auth_token.present? && auth_token[:user_id].present?
  end
end
