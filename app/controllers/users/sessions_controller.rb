# frozen_string_literal: true

module Users
  class SessionsController < ApplicationController
    skip_before_action :validate_user!

    def signin
      user = User.where(username: signin_params[:username]).first
      warden.set_user(user, scope: :user)
      render json: user.to_h
    end

    private

    def signin_params
      params.require(:user).permit(:username, :password)
    end
  end
end
