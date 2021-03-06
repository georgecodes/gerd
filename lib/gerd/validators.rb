require 'gerd/model/model'
require 'gerd/inspections/diffs/organisation'
require 'gerd/inspections/diffs/repositories'

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
          Gerd::Validation::Diff.new( Proc.new { | e, a | e.organisation == a.organisation}, "Organisations"),
      ]


    class Validator

      def initialize(expected_state, actual_state)
        @expected = expected_state
        @actual = actual_state
      end

      def validate
        validation_result = []
        validation_result << Gerd::Inspections::Organisation.inspect_organisations(@expected, @actual)
        validation_result << Gerd::Inspections::Repositories.inspect_repositories(@expected, @actual)
        validation_result << Gerd::Inspections::Organisation.inspect_teams(@expected, @actual)
        report = validation_result.flatten.collect { | res | res.message }
        report
      end

      def collect_actions
        actions = []
        actions << Gerd::Inspections::Organisation.inspect_organisations(@expected, @actual)
        actions << Gerd::Inspections::Repositories.inspect_repositories(@expected, @actual)
        actions << Gerd::Inspections::Organisation.inspect_teams(@expected, @actual)
        actions.flatten.collect { | res | res.actions }
      end
    end

 end   

end