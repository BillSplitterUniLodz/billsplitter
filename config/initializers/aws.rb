require 'dynamoid'

Aws.config.update(
  region: 'us-west-2',
  credentials: Aws::Credentials.new('local', 'local'),
)
Dynamoid.configure do |config|
  config.endpoint = "http://localhost:8000"
  config.access_key = 'local'
  config.secret_key = 'local'
  config.region = 'us-west-2'
end
