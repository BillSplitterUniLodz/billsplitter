Aws.config.update(
  region: 'us-west-2',
  credentials: Aws::Credentials.new('secret', 'secret')
)
require 'dynamoid'

Dynamoid.configure do |config|
  config.endpoint = 'http://localhost:8000'
end
