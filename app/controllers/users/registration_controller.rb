class Users::RegistrationController < ApplicationController
  skip_before_action :validate_user!

  def sign_up
    user = User.create(signup_params.merge(uuid: SecureRandom.uuid))
    warden.set_user(user, scope: :user)
    render json: user.to_h.merge(jwt_token:  generate_token(user, :user))
  end

  private

  def signup_params
    params.require(:user).permit(:username, :email, :password)
  end
end
