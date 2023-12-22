class UserRepository
  def self.find_for_jwt_authentication(sub)
    user = User.where(id: sub)&.first
  end
end

module RevocationStrategy
  module_function

  def jwt_revoked?(payload, user)
    Time.at(payload["exp"].to_i) < Time.now
  end
end
Warden::JWTAuth.configure do |config|
  config.secret = Rails.application.credentials.warden_key_base
  config.dispatch_requests = [['POST', %r{^/login$}]]
  config.mappings  = { user: UserRepository }
  config.revocation_strategies = { user: RevocationStrategy }
end
