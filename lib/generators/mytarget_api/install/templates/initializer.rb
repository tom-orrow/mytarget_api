MytargetApi.configure do |config|
  # Authorization parameters (not needed when using an external authorization):
  # config.app_id       = '123'
  # config.app_secret   = 'AbCdE654'
  # config.redirect_uri = 'http://example.com/oauth/callback'

  # config.is_sandbox = true
  # config.api_version = 1

  # Faraday adapter to make requests with:
  # config.adapter = :net_http

  # HTTP verb for API methods (:get or :post)
  # config.http_verb = :get

  # Logging parameters:
  # log everything through the rails logger
  config.logger = Rails.logger

  # log requests' URLs
  # config.log_requests = true

  # log response JSON after errors
  # config.log_errors = true

  # log response JSON after successful responses
  # config.log_responses = false
end
