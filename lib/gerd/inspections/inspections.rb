module Gerd
  module Inspections
    
    def self.inspect_organisations(expected, actual)
       if expected.organisation == actual.organisation
         return Gerd::Inspections::Diff.new(true, "Organisations match")
        else
          return Gerd::Inspections::Diff.new(false, "Expected #{expected.organisation} but found #{actual.organisation}")
        end
    end

    def self.inspect_teams(expected, actual)
      return Gerd::Inspections::Diff.new(true, "Teams match")
    end

    class Diff

      def initialize(state, message)
        @state = state
        @message = message
      end

      def passed
        @state
      end

    end
  end

end