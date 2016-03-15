require 'inquirer'
require 'frigate/compose'

module Frigate::Commands
  class Create
    def initialize(args, options)
      @compose = Frigate::Compose.new

      name = args[0]

      template = ask_template
      image = ask_image(name)
      base = nil

      if template == 'custom'
        base = ask_base
      end

      source = File.join(File.join(File.dirname(__FILE__), '/../../../tpl/create'), template)

      FileUtils.mkdir_p(name)
      FileUtils.cp_r(File.join(source, '/.'), name)

      readme = File.join(name, 'README.md')
      File.write(readme, File.read(readme).gsub(/\#\{name\}/, name))

      self.send("handle_#{template}", name, base: base, image: image)

      puts "New #{template} service created in #{File.join(Dir.pwd, name)}"
    end

    private

    def ask_template
      templates = %w(custom node.js)
      values = %w(custom node)
      idx = Ask.list 'Which template would you like to use?', templates
      values[idx]
    end

    def ask_image(name)
      Ask.input 'What will be the image source for this service?',
                default: "#{File.basename(Dir.pwd)}/#{name}:latest"
    end

    def ask_base
      Ask.input 'On what image is this service based on?',
                default: 'scratch'
    end

    def handle_node(name, answers)
      FileUtils.mkdir_p "#{name}/lib"
      FileUtils.mkdir_p "#{name}/test"
      FileUtils.touch("#{name}/lib/.gitkeep")
      FileUtils.touch("#{name}/test/.gitkeep")

      config = {
        'image' => answers[:image]
      }

      override = {
        'build' => "./#{name}",
        'command' => 'nodemon .',
        'volumes' => [
          "./#{name}/server.js:/usr/src/app/server.js",
          "./#{name}/lib:/usr/src/app/lib",
          "./#{name}/test:/usr/src/app/test"
        ]
      }

      @compose.add_service(name, config, override)
    end

    def handle_custom(name, answers)
      File.write(File.join(name, 'Dockerfile'), "FROM #{answers[:base]}")

      @compose.add_service(name, {'image' => answers[:image]}, {'build' => "./#{name}"})
    end
  end
end
