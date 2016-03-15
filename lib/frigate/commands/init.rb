module Frigate::Commands
  class Init
    def initialize(args, options)
      folder = args[0]
      folder and FileUtils.mkdir_p(folder)

      source = File.expand_path('../../../tpl/init', File.dirname(__FILE__))
      destination = if folder then File.join(Dir.pwd, folder) else Dir.pwd end

      FileUtils.cp_r(File.join(source, '/.'), destination)

      readme = File.join(destination, 'README.md')
      File.write(readme, File.read(readme).gsub(/\#\{name\}/, File.basename(destination)))

      puts "Project initialized in #{destination}"
    end
  end
end
