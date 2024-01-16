require 'jwt'

module TokenService
  SECRET_KEY = 'your_secret_key_here' # Replace with your secret key

  def self.generate_token(group_id)
    payload = { group_uuid: group_id }
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    decoded.first
  rescue JWT::DecodeError
    nil
  end
end