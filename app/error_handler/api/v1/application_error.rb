
module Api
  module V1

    # A plain old ruby class inheriting from StandardError
    # This class uses some really cool ruby metaprogramming tricks in order to display errors
    class ApplicationError < StandardError

      # responds to all the below attributes
      attr_accessor :config,
                    :code,
                    :message,
                    :http_code

      # We pass config hash of the sort
      # {message: 'Some Error Message', http_code: 501}
      def initialize(config)
        @config = config
        @message = config[:message]
        @http_code = config[:http_code]
      end


      class << self
        # Whenever we call something like ApplicationError::SomeCustomError("message")
        # this method is triggered. We then do a look up in an error types
        # hash and then determine what error object to instantiate.
        # If you want to raise an error with the default message, just call the name without passing any value
        #
        # @note: To understand better @see https://apidock.com/ruby/Module/const_missing
        #
        def method_missing(name, *args)
          err_hash = get_error_type(name)

          if err_hash.is_a? Hash and args.size <= 1
            err_hash[:name] = name
            err_hash[:message] = args[0] if args.size == 1
            Api::V1::ApplicationError.new(err_hash)
          else
            super
          end
        end

        # This method is triggered when a default error message is to
        # be returned.
        # @see ApplicationError#method_missing
        def const_missing(name)
          err_hash = get_error_type(name)

          if err_hash.is_a? Hash
            err_hash[:name] = name
            Api::V1::ApplicationError.new(err_hash)
          else
            super
          end
        end


      end

      def self.get_error_type(name)
        ERROR_TYPES.fetch(name.to_s.underscore.to_sym)
      end

      private
      # These are base errors that can be thrown in the system.
      # If you need to customize the message object, pass it inside the
      # error you are throwing.
      #
      # e.g Api::V1::ApplicationError::NotFound("The user you are looking for doesnt exist!")
      ERROR_TYPES = {
        authentication_failure: { http_code: 401, message: 'The user is not authenticated.' },
        not_found: { http_code: 404, message: 'The requested resource was not found.' },
        validation_error: { http_code: 400, message: 'Validation failed.' },
        unauthorized: { http_code: 403, message: 'Access to the resource is unauthorized.' },
        server_error: { http_code: 500, message: 'An internal server error occurred.' }
      }
    end

  end
end

