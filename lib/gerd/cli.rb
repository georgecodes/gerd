require 'thor'
require 'open-uri'
require 'json'
require 'gerd/audit/audit'
require 'gerd/github_client'
require 'gerd/formatters'
require 'gerd/validators'
require 'gerd/model/model'
require 'gerd/invoke'

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

    desc "apply <organisation>", "Applies supplied model to GitHub"
    option :file, :type => :string, :aliases => ['f'], :required => true
    option :token, :type => :string, :aliases => ['t']
    option :delete, :type => :boolean
    def apply(organisation)
      token = options[:token] if options[:token]
      client = Gerd::GHClient.create(token)
      auditor = Gerd::Audit.new(client, organisation)
      expected_state = Gerd::Model::GithubState.from_json(File.read(options[:file]))
      actual_state = Gerd::Model::GithubState.new(auditor.full_audit)
      validator = Gerd::Validation::Validator.new(expected_state, actual_state)
      actions = validator.collect_actions.flatten
      actions.each do | action |
        action.invoke(client, options)
      end
    end

    desc "exec <script>", "Runs arbitrary scripts against your audit file"
    option :input, :type => :string, :aliases => ['i'], :required => true
    option :output, :type => :string, :aliases => ['o']
    def exec(script)
      current_state = Gerd::Model::GithubState.from_json(File.read(options[:input]))
      script = File.read(script)
      exec_helper = Gerd::Helpers::Exec.new(script)
      exec_helper.exec(current_state)
      formatter = Gerd::Formatters.find_formatter(options[:output])
      formatter.print(current_state.serialize, options)
      
    end

  end
end