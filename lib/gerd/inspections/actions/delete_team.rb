module Gerd
  module Inspections
    module Actions

      class DeleteTeam

        def initialize(team)
          @team_id = team[:id]
        end

        def invoke(client, options = {})
          client.delete_team(@team_id)
        end

      end

    end
  end
end