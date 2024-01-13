class ApplicationController < ActionController::API
  before_action :current_user

  def generate_token(user, scope, env)
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(user, scope, nil)
    token
  end

  def warden
    request.env['warden']
  end

  private 
  
  def current_user
    @current_user ||= warden.authenticate!
  end
end
