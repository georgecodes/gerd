require 'octokit'
require 'octokit/repository'
require 'json'

module Gerd
  class Audit

    def initialize(client, org)
      @org = org
      @client = client
    end

    def full_audit
      audit = {}
      members = find_members
      teams = find_teams
      repositories = find_repos
      audit['organisation'] = @org
      audit['teams'] = teams
      audit['repositories'] = repositories
      audit['members'] = members
      audit
    end
  
    def find_repos
      repos = @client.org_repos @org
      repositories = {}
      
      repos.each do | repo |
        repo_conf = {
          'private' => repo.private
        }
        repositories[repo.name] = repo_conf
      end
      repositories
    end

    def find_teams
      teams = @client.org_teams @org
      team_conf = {}
      teams.each do | team |
        members = @client.team_members(team.id)
        team_members = []
        members.each do | member |
          team_members << member.login
          
        end
        repos = @client.team_repos(team.id)
        team_repos = []
        repos.each do | repo |
          team_repos << {
            :id => repo.id,
            :name => repo.name
          }
        end
        team_conf[team.name] = {
          :id => team.id,
          :description => team.description,
          :privacy => team.privacy,
          :members => team_members,
          :repos => team_repos
        }
      end
      team_conf
    end

    def find_members
      members = @client.org_members @org
      members_conf = {}
      members.each do | member |
        members_conf[member.login] = {
          :id => member.id
        }
      end
      members_conf
    end

  end
end