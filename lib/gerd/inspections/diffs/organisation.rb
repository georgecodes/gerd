require 'gerd/inspections/actions/update_name_action'
require 'gerd/inspections/actions/create_team'
require 'gerd/inspections/actions/delete_team'

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

      def self.inspect_teams(expected, actual)
        diffs = []

        diffs << inspect_expected_teams_exist(expected, actual)

        diffs << inspect_no_extra_teams_exist(expected, actual)

        diffs.flatten
      end

      def self.inspect_expected_teams_exist(expected, actual)

        diffs = []

        expected_teams = expected.teams
        actual_teams = actual.teams

        expected_teams.keys.each do | expected_team |
          if !actual_teams.keys.include? expected_team
            team_to_create = expected_teams[expected_team]
            action = Gerd::Inspections::Actions::CreateTeam.new(expected_team, expected.organisation, team_to_create)
            diffs << Gerd::Inspections::Diff.new(false, "I expected to see team #{expected_team} but did not", [action])
          end

        end

        diffs.flatten

      end

      def self.inspect_no_extra_teams_exist(expected, actual)

        diffs = []

        expected_teams = expected.teams
        actual_teams = actual.teams

        actual_teams.keys.each do | team |

          if !expected_teams.keys.include? team

            action = Gerd::Inspections::Actions::DeleteTeam.new(actual_teams[team])
            diffs << Gerd::Inspections::Diff.new(false, "I did not expect to see team #{team} but saw it anyway", [action])
          end

        end

        diffs

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