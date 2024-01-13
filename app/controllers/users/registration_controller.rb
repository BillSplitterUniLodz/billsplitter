class Users::RegistrationController < ApplicationController
  skip_before_action :current_user

  def sign_up
    user = User.create(signup_params.merge(uuid: SecureRandom.uuid))
    warden.set_user(user, scope: :default)
    render json: user.to_h
  end

  private

  def signup_params
    params.require(:user).permit(:username, :email, :password)
  end
end
