require 'inquirer'
require 'colorize'
require 'frigate/compose'

module Frigate::Commands
  class Add
    def initialize(args, options)
      @compose = Frigate::Compose.new

      name = args[0]

      image = ask_image(name)

      @compose.add_service name, 'image' => image

      puts "Service #{name} added"
    end

    def ask_image(name)
      Ask.input 'What will be the image source for this service?',
                default: "#{name}:latest"
    end
  end
end
