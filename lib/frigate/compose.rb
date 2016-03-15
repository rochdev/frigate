require 'yaml'

module Frigate
  class Compose
    def add_service(name, config, override = nil)
      config_file = read_base
      config_file['services'][name] = config

      write_base config_file

      if override
        override_file = read_override
        override_file['services'][name] = override

        write_override override_file
      end
    end

    def remove_service(name)
      config_file = read_base
      override_file = read_override

      config_file['services'].delete(name)
      override_file['services'].delete(name)

      write_base config_file
      write_override override_file
    end

    private

    def read_base
      normalize(YAML.load(File.read('docker-compose.yml')))
    end

    def read_override
      normalize(YAML.load(File.read('docker-compose.override.yml')))
    end

    def write_base(data)
      File.write('docker-compose.yml', data.to_yaml)
    end

    def write_override(data)
      File.write('docker-compose.override.yml', data.to_yaml)
    end

    def normalize(data)
      data['services'] ||= {}
      data
    end
  end
end
