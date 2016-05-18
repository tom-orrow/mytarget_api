module MytargetApi
  # A module containing the methods for authorization.
  #
  # @note `MytargetApi::Authorization` extends `MytargetApi` so these methods should be called from the latter.
  module Authorization
    # Authorization options.
    OPTIONS = {
      client: {
        site:          'http://target.my.com',
        authorize_url: '/oauth2/authorize',
        token_url:     "/api/v%/oauth2/token.json"
      },
      client_credentials: {
        'auth_scheme' => 'request_body'
      }
    }

    # URL for redirecting the user to Mytarget where he gives the application all the requested access rights.
    # @option options [Symbol] :type The type of authorization being used (`:site` and `:client` supported).
    # @option options [String] :redirect_uri URL for redirecting the user back to the application (overrides the global configuration value).
    # @option options [Array] :scope An array of requested access rights (each represented by a symbol or a string).
    # @raise [ArgumentError] raises after receiving an unknown authorization type.
    # @return [String] URL to redirect the user to.
    def authorization_url(options = {})
      type = options.delete(:type) || :site
      # redirect_uri passed in options overrides the global setting
      options[:redirect_uri] ||= MytargetApi.redirect_uri
      options[:scope] = MytargetApi::Utils.flatten_argument(options[:scope]) if options[:scope]

      case type
      when :site
        client.auth_code.authorize_url(options)
      when :client
        client.implicit.authorize_url(options)
      else
        raise ArgumentError, "Unknown authorization type #{type.inspect}"
      end
    end

    # Authorization (getting the access token and building a `MytargetApi::Client` with it).
    # @option options [Symbol] :type The type of authorization being used (`:site` and `:app_server` supported).
    # @option options [String] :code The code to exchange for an access token (for `:site` authorization type).
    # @raise [ArgumentError] raises after receiving an unknown authorization type.
    # @return [MytargetApi::Client] An API client.
    def authorize(options = {})
      type = options.delete(:type) || :site

      options[:redirect_uri] ||= MytargetApi.redirect_uri

      case type
      when :site
        code  = options.delete(:code)
        token = client.auth_code.get_token(code, options)
      when :app_server
        token = client.client_credentials.get_token(options, OPTIONS[:client_credentials].dup)
      else
        raise ArgumentError, "Unknown authorization type #{type.inspect}"
      end

      Client.new(token)
    end

  private
    def client
      OPTIONS[:client][:token_url].gsub!(/\/v%\//, "/v#{MytargetApi.api_version}/")
      @client ||= OAuth2::Client.new(MytargetApi.app_id, MytargetApi.app_secret, OPTIONS[:client])
    end
  end
end
