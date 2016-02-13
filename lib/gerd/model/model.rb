require 'json'

module Gerd
  module Model

    class GithubState

      def initialize(state_content)
        @content = state_content
      end

      def valid?
        begin
          parsed_content = JSON.parse(@content)
        rescue
          return false
        end
        validators = []
        validators << Gerd::Model::Validator.new( Proc.new { | data | data['organisation'] != nil }, "Should have an organisation present")
        validators << Gerd::Model::Validator.new( Proc.new { | data | data['teams'].class == Hash }, "Should have a teams element present")
        validators << Gerd::Model::Validator.new( Proc.new { | data | data['repositories'].class == Hash }, "Should have a repositories element present")
        validators << Gerd::Model::Validator.new( Proc.new { | data | data['members'].class == Hash }, "Should have a members element present")
        
        failures = []
        validators.each do | validator |
          result = validator.evaluate(parsed_content)
          failures << result unless result.valid?
        end
        failures.length == 0
      end

    end



    class Validator

        def initialize(expression, message)
          @expression = expression
          @message = message
        end

        def evaluate(content)
          res = @expression.call(content)
          Gerd::Model::ValidationResult.new(res, @message)
        end

    end

    class ValidationResult

      def initialize(result, message)
        @result = result
        @message = message
      end

      def valid?
        @result
      end

    end

  end
end