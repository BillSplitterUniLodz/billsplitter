class ApplicationController < ActionController::API
  before_action :validate_user!

  private 

  def warden
    request.env['warden']
  end

  def current_user
    @current_user
  end

  def render_access_denied
    render json: { message: 'Access denied' }, status: 403
  end

  def validate_user!
    @current_user = request.env["warden"].authenticate!(scope: :user)
  end
end
