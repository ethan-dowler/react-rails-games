module Api
  class AuthenticationController < ApiController
    def create
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        render json: { auth_token: JsonWebToken.encode({ user_id: user.id }) }
      else
        render status: :unauthorized, json: { error: 'Invalid Username/Password' }
      end
    end
  end
end
