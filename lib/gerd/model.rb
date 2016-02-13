require 'json'

module Gerd
  module Model

    class GithubState

      attr_accessor :organisation, :teams, :members, :repositories, :failures

      def initialize(state_content)
        
        begin
          parsed_content = JSON.parse(state_content)
        rescue
          raise "Parse error #{state_content}"
        end
        validators = []
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['organisation'] != nil }, "Should have an organisation present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['teams'].class == Hash }, "Should have a teams element present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['repositories'].class == Hash }, "Should have a repositories element present")
        validators << Gerd::Model::SchemaValidator.new( Proc.new { | data | data['members'].class == Hash }, "Should have a members element present")
        failures = []
        validators.each do | validator |
          result = validator.evaluate(parsed_content)
          failures << result unless result.valid?
        end

        @failures = failures
        raise 'validation errors' unless failures.length == 0

        @organisation = parsed_content['organisation']
        @teams = parsed_content['teams']
        @members = parsed_content['members']
        @repositories = parsed_content['repositories']

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