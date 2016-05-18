module MytargetApi
  # A module that handles method result processing.
  #
  # It implements method blocks support, result typecasting and raises `MytargetApi::Error` in case of an error response.
  module Result
    class << self
      # The main method result processing.
      # @param [Hashie::Mash] response The server response in mash format.
      # @param [Symbol] type The expected result type (`:boolean` or `:anything`).
      # @param [Proc] block A block passed to the API method.
      # @return [Array, Hashie::Mash] The processed result.
      # @raise [MytargetApi::Error] raised when Mytarget returns an error response.
      def process(response, type, block)
        if response.respond_to?(:each)
          # enumerable response receives :map with a block when called with a block
          # or is returned untouched otherwise
          block.nil? ? response : response.map(&block)
        else
          # non-enumerable response is typecasted
          # (and yielded if block_given?)
          response = typecast(response, type)
          block.nil? ? response : block.call(response)
        end
      end

    private
      def typecast(parameter, type)
        case type
        when :boolean
          # '1' becomes true, '0' becomes false
          !parameter.to_i.zero?
        else
          parameter
        end
      end
    end
  end
end
