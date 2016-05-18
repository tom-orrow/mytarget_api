module MytargetApi
  # An API method. It is responsible for generating it's full name and determining it's type.
  class Method
    include Resolvable

    # A pattern for names of methods with a boolean result.
    PREDICATE_NAMES = /^is.*\?$/

    # Calling the API method.
    # It delegates the network request to `API.call` and result processing to `Result.process`.
    # @param [Hash] args Arguments for the API method.
    def call(args = {}, &block)
      if @previous_resolver.name
        args[:http_verb] = @name
        @name = @previous_resolver.name
      end

      response = API.call(full_name, args, token)
      Result.process(response, type, block)
    end

  private
    def full_name
      @name.gsub(/[^A-Za-z._]/, '') + '.json'
    end

    def type
      @name =~ PREDICATE_NAMES ? :boolean : :anything
    end
  end
end
