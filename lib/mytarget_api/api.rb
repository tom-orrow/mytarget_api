module MytargetApi
  # A low-level module which handles the requests to MyTarget API and returns their results as mashes.
  #
  # It uses Faraday with middleware underneath the hood.
  module API
    # URL prefix for calling API methods.
    URL_PREFIX_SANDBOX = 'https://target-sandbox.my.com/api/'
    URL_PREFIX_PRODUCTION = 'https://target.my.com/api/'

    class << self
      # API method call.
      # @param [String] method_name A full name of the method.
      # @param [Hash] args Method arguments.
      # @param [String] token The access token.
      # @return [Hashie::Mash] Mashed server response.
      def call(method_name, args = {}, token = nil)
        http_verb = args.delete(:http_verb) || MytargetApi.http_verb
        api_version = args.delete(:api_version) || MytargetApi.api_version
        flat_arguments = Utils.flatten_arguments(args)
        url_prefix = MytargetApi.is_sandbox ? URL_PREFIX_SANDBOX : URL_PREFIX_PRODUCTION
        connection(url: "#{url_prefix}/v#{api_version}/", token: token).send(http_verb, method_name, flat_arguments).body
      end

      # Faraday connection.
      # @param [Hash] options Connection options.
      # @option options [String] :url Connection URL (either full or just prefix).
      # @option options [String] :token OAuth2 access token (not used if omitted).
      # @return [Faraday::Connection] Created connection.
      def connection(options = {})
        url   = options.delete(:url)
        token = options.delete(:token)

        MytargetApi.faraday_options[:headers] ||= {}
        MytargetApi.faraday_options[:headers]['Authorization'] = "Bearer #{token}"

        Faraday.new(url, MytargetApi.faraday_options) do |builder|
          builder.request :multipart
          builder.request :url_encoded
          builder.request :retry, MytargetApi.max_retries

          builder.response :mytarget_logger
          builder.response :mashify
          builder.response :oj

          builder.adapter MytargetApi.adapter
        end
      end
    end
  end
end
