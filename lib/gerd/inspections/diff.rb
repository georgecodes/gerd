module Gerd
  module Inspections 

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
