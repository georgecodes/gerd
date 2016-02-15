module Gerd
  module Inspections
    module Actions
      
      class ChangeRepoPrivacy

        def initialize(repo_to_change, privacy_state)
          @repo = repo_to_change
          @privacy_state = privacy_state
        end

      end

    end
  end
end