require 'json'
require 'gerd/exceptions'

module Gerd
  module Model

    class GithubState

      attr_accessor :organisation, :teams, :members, :repositories, :failures

      def self.from_json(json)
         begin
          return Gerd::Model::GithubState.new(JSON.parse(json))
        rescue => e
          raise Gerd::Exceptions::ValidationException.new("Couldn't parse JSON")
        end
        
      end

      def initialize(state_content)
        
        validators = []
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['organisation'] != nil }, "Should have an organisation present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['teams'].class == Hash }, "Should have a teams element present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['repositories'].class == Hash }, "Should have a repositories element present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['members'].class == Hash }, "Should have a members element present")
        failures = []
        validators.each do | validator |
          result = validator.evaluate(state_content)
          failures << result unless result.valid?
        end

        @failures = failures
        raise Gerd::Exceptions::ValidationException.new("Failed to validate") unless failures.length == 0

        @organisation = state_content['organisation']
        @teams = state_content['teams']
        @members = state_content['members']
        @repositories = state_content['repositories']

      end

    end

    class SchemaValidator

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