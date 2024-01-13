module UserRepository
  def self.find_for_jwt_authentication(sub)
    User.where(user_uuid: sub).first
  end
end


class RevocationStrategy
  def self.revoke_jwt(payload, user)
    # TODO: Do something to revoke a JWT token
  end

  def self.jwt_revoked?(payload, user)
    # TODO: Do something to check whether a JWT token is revoked
  end
end



Warden::JWTAuth.configure do |config|
  config.secret = ENV.fetch('WARDEN_JWT_SECRET_KEY', "abc")
  config.mappings = { user: 'UserRepository', default: 'UserRepository' }
  config.dispatch_requests = [['POST', %r{^/signin$}]]
  config.revocation_requests = [['DELETE', %r{^/logout$}]]
  config.revocation_strategies = { default: RevocationStrategy }
end
