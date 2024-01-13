module UserRepository
  def self.find_for_jwt_authentication(sub)
    User.where(user_uuid: sub)&.first
  end
end


class RevocationStrategy
  def self.jwt_revoked?(payload, user)
    Time.at(payload["exp"].to_i) < Time.now
  end
end



Warden::JWTAuth.configure do |config|
  config.secret = ENV.fetch('WARDEN_JWT_SECRET_KEY', "abc")
  config.mappings = { user: 'UserRepository' }
  config.dispatch_requests = [['POST', %r{^/signin$}]]
  config.revocation_requests = [['DELETE', %r{^/logout$}]]
  config.revocation_strategies = { user: RevocationStrategy }
end
