module Api
  class AuthController < ApiController
    attr_reader :current_user

    skip_forgery_protection
    before_action :authenticate_request!

  protected

    def authenticate_request!
      render json: { error: "Invalid Request" }, status: :unauthorized and return unless user_id_in_token?

      @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      redirect_to login_index_path
    end

  private

    # expects Authentication header to be
    # => "Bearer BEARER_TOKEN"
    def bearer_token
      @bearer_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(bearer_token)
    end

    def user_id_in_token?
      bearer_token && auth_token && auth_token[:user_id].to_i.present?
    end
  end
end
