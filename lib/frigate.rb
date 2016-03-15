require 'frigate/version'
require 'frigate/commands/init'
require 'frigate/commands/create'
require 'frigate/commands/add'
require 'frigate/commands/remove'
require 'rubygems'
require 'commander'

module Frigate
  class App
    include Commander::Methods
    # include whatever modules you need

    def run
      program :name, 'frigate'
      program :version, '0.0.1'
      program :description, 'Manage docker'

      command :create do |c|
        c.syntax = 'frigate create <name>'
        c.summary = 'create a new service'
        c.description = 'create a new service'
        c.action Frigate::Commands::Create
      end

      command :add do |c|
        c.syntax = 'frigate add <name>'
        c.summary = 'add an external service'
        c.description = 'add an external service'
        c.action Frigate::Commands::Add
      end

      command :remove do |c|
        c.syntax = 'frigate remove <name>'
        c.summary = 'remove a service'
        c.description = 'remove a service'
        c.action Frigate::Commands::Remove
      end

      command :init do |c|
        c.syntax = 'frigate init [folder]'
        c.summary = 'initialize a new docker-compose project'
        c.description = 'initialize a new docker-compose project'
        c.action Frigate::Commands::Init
      end

      run!
    end
  end
end

Frigate::App.new.run if $0 == __FILE__
