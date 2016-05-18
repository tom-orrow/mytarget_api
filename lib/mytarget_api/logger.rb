module MytargetApi
  # Faraday middleware for logging requests and responses.
  #
  # It's behaviour depends on the logging options in the configuration.
  class Logger < Faraday::Response::Middleware
    # Creates a middleware instance.
    # The logger is set from `:logger` configuration option.
    def initialize(app)
      super(app)
      @logger = MytargetApi.logger
    end

    # Logs the request if needed.
    # @param [Hash] env Request data.
    def call(env)
      if MytargetApi.log_requests?
        @logger.debug "#{env[:method].to_s.upcase} #{env[:url].to_s}"
        @logger.debug "body: #{env[:body].inspect}" unless env[:method] == :get
      end

      super
    end

    # Logs the response (successful or not) if needed.
    # @param [Hash] env Response data.
    def on_complete(env)
      @logger.debug env[:raw_body] if MytargetApi.log_responses?
    end
  end

  Faraday::Response.register_middleware mytarget_logger: Logger
end
