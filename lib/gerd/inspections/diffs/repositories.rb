require 'gerd/inspections/diff'
require 'gerd/inspections/actions/create_repo'
require 'gerd/inspections/actions/delete_repo'

module Gerd
  module Inspections

    module Repositories
    
      def self.inspect_repositories(expected, actual)

        diffs = []

        diffs << inspect_required_repos_exist(expected, actual)

        diffs << inspect_no_extra_repos_exist(expected, actual)

        diffs.flatten
        
      end

      def self.inspect_required_repos_exist(expected, actual)

        diffs = []

        expected_repos = expected.repositories
        actual_repos= actual.repositories

        expected_repos.keys.each do | expected |
          if !actual_repos.keys.include? expected
            action = Gerd::Inspections::Actions::CreateRepo.new(expected_repos[expected])
            diffs << Gerd::Inspections::Diff.new(false, "I expected to see repository #{expected} but did not", [action])
          end

        end

        diffs

      end

      def self.inspect_no_extra_repos_exist(expected, actual)

        diffs = []

        expected_repos = expected.repositories
        actual_repos= actual.repositories

        actual_repos.keys.each do | repo |
          if !expected_repos.keys.include? repo
            action = Gerd::Inspections::Actions::DeleteRepo.new(actual_repos[repo])
            diffs << Gerd::Inspections::Diff.new(false, "I did not expect to see repository #{repo} but saw it anyway", [action])
          end

        end

        diffs

      end

    end

  end

end