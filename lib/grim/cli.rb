require 'thor'
require 'open-uri'
require 'json'
require 'grim/audit'
require 'grim/github_client'
require 'grim/formatters'

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

    

  end
end