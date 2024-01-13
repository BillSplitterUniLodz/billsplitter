require 'dynamoid'
Aws.config.update(
  region:  ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"]),
)
Dynamoid.configure do |config|
  config.endpoint = ENV["DYNAMO_ENDPOINT"]
  config.access_key = ENV["AWS_ACCESS_KEY_ID"]
  config.secret_key = ENV["AWS_SECRET_ACCESS_KEY"]
  config.region = ENV['AWS_REGION']
end
