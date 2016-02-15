require 'gerd/inspections/actions/update_name_action'

module Gerd
  module Inspections

    module Organisation
    
      def self.inspect_organisations(expected, actual)
        if expected.organisation == actual.organisation
           return Gerd::Inspections::Organisation::Diff.new(true, "Organisations match")
         else
           action = Gerd::Inspections::Organisation::Actions::UpdateName.new(expected, actual) 
           return Gerd::Inspections::Organisation::Diff.new(
            false, "Expected #{expected.organisation} but found #{actual.organisation}",
            [action]
            )
        end
      end

      class Diff

        attr_accessor :passed, :message, :actions

        def initialize(state, message, actions = [])
          @passed = state
          @message = message
          @actions = actions
        end

      end

    end

  end

end