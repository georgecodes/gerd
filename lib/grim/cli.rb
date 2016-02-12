require 'thor'
require 'open-uri'
require 'json'
require 'grim/audit'
require 'grim/github_client'
require 'grim/formatters'
require 'grim/validators'
require 'grim/model'

module Grim
  class CLI < Thor

    desc "audit <organization>", "Introspects the GitHub environment for the given organisation"
    option :token, :type => :string, :aliases => ['t']
    option :file, :type => :string, :aliases => ['f']
    option :overwrite, :type => :boolean, :aliases => ['o']
    def audit(organisation)
      token = options[:token] if options[:token]
      client = Grim::GHClient.create(token)
      auditor = Grim::Audit.new(client, organisation)
      content = auditor.full_audit
      formatter = Grim::Formatters.find_formatter(options[:file])
      formatter.print(content, options)
    end

    desc "validate <organisation>", "Checks whether the organisation actually has the configuration supplied"
    option :expected, :type => :string, :aliases => ['e'], :required => true
    option :token, :type => :string, :aliases => ['t']
    option :file, :type => :string, :aliases => ['f']
    def validate(organisation)
      token = options[:token] if options[:token]
      client = Grim::GHClient.create(token)
      auditor = Grim::Audit.new(client, organisation)
      expected_state = Grim::Model::GithubState.new(File.read(options[:expected]))
      actual_state = Grim::Model::GithubState.new(auditor.full_audit)
      validator = Grim::Validation::Validator.new(expected_state, actual_state)
      content = validator.validate
      formatter = Grim::Formatters.find_formatter(options[:file])
      formatter.print(content, options)
    end

  end
end