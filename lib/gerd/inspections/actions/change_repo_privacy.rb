module Gerd
  module Inspections
    module Actions
      
      class ChangeRepoPrivacy

        def initialize(repo_to_change, privacy_state)
          @repo = repo_to_change
          @privacy_state = privacy_state
        end

        def invoke(client, options = {})
          
          client.set_private(@repo) if @privacy_state == true
          client.set_public(@repo) if @privacy_state == false
          
        end

      end

    end
  end
end