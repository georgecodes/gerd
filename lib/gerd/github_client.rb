require 'octokit'
require 'octokit/repository'
require 'json'

module Gerd
  class GHClient

    def self.create(explicit_token)
      Octokit.auto_paginate = true
      token = explicit_token 
      token = ENV['GRIM_TOKEN'] unless token
      token = from_local unless token
      token = from_global unless token
      client = token ? Octokit::Client.new(:access_token => token) : client = Octokit::Client.new
      client
    end

    def self.from_local()
       file = File.join(Dir.pwd, ".grim")
       return unless File.exist?(file)
       local_file = File.read(file)
       grim_conf = JSON.parse(local_file)
       grim_conf['token']
    end
  
    def self.from_global()
        file = File.join(ENV['HOME'], ".grim")
        return unless File.exist?(file)
        global_file = File.read(file)
        grim_conf = JSON.parse(global_file)
        grim_conf['token']
    end

  end
end