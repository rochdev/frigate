require 'frigate/compose'

module Frigate::Commands
  class Remove
    def initialize(args, options)
      @compose = Frigate::Compose.new

      name = args[0]

      @compose.remove_service name

      puts "Service #{name} removed"
    end
  end
end
