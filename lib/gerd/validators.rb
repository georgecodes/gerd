require 'gerd/model/model'

module Gerd
  module Validation

    class Diff

      def initialize(expression, name)
        @expression = expression
        @name = name
      end

      def validate(expected, actual)
        puts expected
        res = @expression.call(expected, actual)
        res ? "#{@name} passed" : "#{@name} failed"
      end

    end

    StandardDiffs =[
          Gerd::Validation::Diff.new( Proc.new { | e, a | e.organisation == a.organisation}, "Organisations")
      ]


    class Validator

      def initialize(expected_state, actual_state)
        @expected = expected_state
        @actual = actual_state
      end

      def validate
        validation_result = []
        Gerd::Validation::StandardDiffs.each do | validator |
          result = validator.validate(@expected, @actual)
          validation_result << result
        end
        validation_result
      end

    end

 end   

end