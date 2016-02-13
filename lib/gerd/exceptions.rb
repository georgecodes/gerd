module Gerd
  module Exceptions

    class ValidationException < StandardError

      attr_reader :object

      def initialize(object)
        @object = object
      end

    end

  end

end