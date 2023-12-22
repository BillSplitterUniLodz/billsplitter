class Users::AuthenticationController < ApplicationController
  skip_before_action :validate_user!, only: :create

  def create
    user = User.where(email: auth_params[:email]).first
    if user && user.compare_password?(auth_params[:password])
      aud = Warden::JWTAuth::EnvHelper.aud_header(request.env)
      token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, aud)
      render json: { token: token } 
    else
      render_access_denied 
    end
  end

  def auth_params
    params.require(:authentication).permit(:email, :password)
  end
end
