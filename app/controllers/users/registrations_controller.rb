class Users::RegistrationsController < ApplicationController
  skip_before_action :validate_user!, only: :create

  def create
    user = User.new(
      id: SecureRandom.uuid, 
      name: registration_params[:name], 
      email: registration_params[:email]
    )
    user.set_password = registration_params[:password]
    if user.valid?
      user.save
      aud = Warden::JWTAuth::EnvHelper.aud_header(request.env)
      token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, aud)
      render json: { token: token } 
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  def registration_params
    params.require(:registration).permit(:name, :email, :password)
  end
end
