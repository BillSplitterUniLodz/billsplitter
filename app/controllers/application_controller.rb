# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :validate_user!

  def generate_token(user, scope)
    aud = Warden::JWTAuth::EnvHelper.aud_header(request.env)
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, scope, aud)
    token
  end

  def warden
    request.env['warden']
  end

  def render_access_denied
    render json: { message: 'Access denied' }, status: :forbidden
  end

  def validate_user!
    @current_user = request.env['warden'].authenticate!(scope: :user)
  end

  private

  attr_reader :current_user
end
