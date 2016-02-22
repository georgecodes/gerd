module Gerd
  module Inspections
    module Actions

      class CreateTeam

        def initialize(team_name, organisation, team_opts)
          @team_name = team_name
          @org = organisation
          @opts = team_opts
        end

        def invoke(client, options = {})
          team_name = @team_name
          description = @opts['description']
          privacy = @opts['privacy']
          repos = []
          repos = @opts['repos'].collect { | repo | "#{@org}/#{repo}" } unless !@opts.has_key?('repos')
          opts = {
            :name => team_name,
            :repo_names => repos,
            :permission => 'admin'
          }
          client.create_team(@org, opts)
        end

      end

    end
  end
end