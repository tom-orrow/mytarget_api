require 'logger'

module MytargetApi
  # General configuration module.
  #
  # @note `MytargetApi::Configuration` extends `MytargetApi` so these methods should be called from the latter.
  module Configuration
    # Available options.
    OPTION_NAMES = [
      :app_id,
      :app_secret,
      :redirect_uri,
      :adapter,
      :http_verb,
      :faraday_options,
      :max_retries,
      :logger,
      :log_requests,
      :log_errors,
      :log_responses,
      :api_version,
      :is_sandbox
    ]

    attr_accessor *OPTION_NAMES

    alias_method :log_requests?,  :log_requests
    alias_method :log_errors?,    :log_errors
    alias_method :log_responses?, :log_responses

    # Default HTTP adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # Default HTTP verb for API methods.
    DEFAULT_HTTP_VERB = :post

    # Default max retries count.
    DEFAULT_MAX_RETRIES = 2

    # Default api version number.
    DEFAULT_API_VERSION = 1

    # Default for sandbox status.
    DEFAULT_IS_SANDBOX = true

    # Logger default options.
    DEFAULT_LOGGER_OPTIONS = {
      requests:  true,
      errors:    true,
      responses: false
    }

    # A global configuration set via the block.
    # @example
    #   MytargetApi.configure do |config|
    #     config.adapter = :net_http
    #     config.logger  = Rails.logger
    #   end
    def configure
      yield self if block_given?
      self
    end

    # Reset all configuration options to defaults.
    def reset
      @adapter         = DEFAULT_ADAPTER
      @http_verb       = DEFAULT_HTTP_VERB
      @faraday_options = {}
      @max_retries     = DEFAULT_MAX_RETRIES
      @logger          = ::Logger.new(STDOUT)
      @log_requests    = DEFAULT_LOGGER_OPTIONS[:requests]
      @log_errors      = DEFAULT_LOGGER_OPTIONS[:errors]
      @log_responses   = DEFAULT_LOGGER_OPTIONS[:responses]
      @api_version     = DEFAULT_API_VERSION
      @is_sandbox      = DEFAULT_IS_SANDBOX
    end

    # When this module is extended, set all configuration options to their default values.
    def self.extended(base)
      base.reset
    end
  end
end
