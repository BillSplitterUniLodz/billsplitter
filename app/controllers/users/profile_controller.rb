class Users::ProfileController < ApplicationController
  def show
    render json: current_user
  end
end
