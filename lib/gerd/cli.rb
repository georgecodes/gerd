require 'thor'
require 'open-uri'
require 'json'
require 'gerd/audit/audit'
require 'gerd/github_client'
require 'gerd/formatters'
require 'gerd/validators'
require 'gerd/model/model'

module Gerd
  class CLI < Thor

    desc "audit <organization>", "Introspects the GitHub environment for the given organisation"
    option :token, :type => :string, :aliases => ['t']
    option :file, :type => :string, :aliases => ['f']
    option :overwrite, :type => :boolean, :aliases => ['o']
    def audit(organisation)
      token = options[:token] if options[:token]
      client = Gerd::GHClient.create(token)
      auditor = Gerd::Audit.new(client, organisation)
      content = auditor.full_audit
      formatter = Gerd::Formatters.find_formatter(options[:file])
      formatter.print(content, options)
    end

    desc "validate <organisation>", "Checks whether the organisation actually has the configuration supplied"
    option :expected, :type => :string, :aliases => ['e'], :required => true
    option :token, :type => :string, :aliases => ['t']
    option :file, :type => :string, :aliases => ['f']
    def validate(organisation)
      token = options[:token] if options[:token]
      client = Gerd::GHClient.create(token)
      auditor = Gerd::Audit.new(client, organisation)
      expected_state = Gerd::Model::GithubState.from_json(File.read(options[:expected]))
      actual_state = Gerd::Model::GithubState.new(auditor.full_audit)
      validator = Gerd::Validation::Validator.new(expected_state, actual_state)
      content = validator.validate
      formatter = Gerd::Formatters.find_formatter(options[:file])
      formatter.print(content, options)
    end

  end
end