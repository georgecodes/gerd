require 'gerd/inspections/diff'
require 'gerd/inspections/actions/create_repo'
require 'gerd/inspections/actions/delete_repo'
require 'gerd/inspections/actions/change_repo_privacy'

module Gerd
  module Inspections

    module Repositories
    
      def self.inspect_repositories(expected, actual)

        diffs = []

        diffs << inspect_required_repos_exist(expected, actual)

        diffs << inspect_no_extra_repos_exist(expected, actual)

        diffs << inspect_repo_privacy(expected, actual)

        diffs.flatten
        
      end

      def self.inspect_required_repos_exist(expected, actual)

        diffs = []

        expected_repos = expected.repositories
        actual_repos= actual.repositories

        expected_repos.keys.each do | expected_repo |
          if !actual_repos.keys.include? expected_repo
            repo_to_create = expected_repos[expected_repo]
            privacy = repo_to_create['privacy']
            action = Gerd::Inspections::Actions::CreateRepo.new(expected_repo, expected.organisation, privacy)
            diffs << Gerd::Inspections::Diff.new(false, "I expected to see repository #{expected_repo} but did not", [action])
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
            action = Gerd::Inspections::Actions::DeleteRepo.new(repo, expected.organisation)
            diffs << Gerd::Inspections::Diff.new(false, "I did not expect to see repository #{repo} but saw it anyway", [action])
          end

        end

        diffs

      end

      def self.inspect_repo_privacy(expected, actual)

        diffs = []

        expected_repos = expected.repositories
        actual_repos= actual.repositories

        expected_repos.each do | repo_name, expected_repo |
          actual_repo = actual_repos[repo_name]
          next if !actual_repo
          if expected_repo['private'] == true && actual_repo['private'] == false
            full_name = "#{expected.organisation}/#{repo_name}"
            action = Gerd::Inspections::Actions::ChangeRepoPrivacy.new(full_name, true)
            diffs << Gerd::Inspections::Diff.new(false, "I expected repo #{repo_name} to be private, but it is not", [action])
          end
          if expected_repo['private'] == false && actual_repo['private'] == true
            full_name = "#{expected.organisation}/#{repo_name}"
            action = Gerd::Inspections::Actions::ChangeRepoPrivacy.new(full_name, false)
            diffs << Gerd::Inspections::Diff.new(false, "I did not expect repo #{repo_name} to be private, but it is", [action])
          end
        end

        diffs

      end

    end

  end

end