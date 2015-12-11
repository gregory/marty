module Marty
  class Nodes::Base < Clamp::Command
    parameter "name", "name of the grid"
    parameter "options ...", "docker machine options", required: false, attribute_name: :options, default: []

    option ['-d', '--driver'], "driver name", "<#{Nodes::DRIVERS.join('|')}>", default: 'virtualbox'

    def execute
      before_create
        #binding.pry
      puts cmd
      Open3.popen3(cmd) do |stdin, stdout, strerr|
        while line = stdout.gets
          puts line
        end
      end
      after_create
    end

    protected

    def cmd
      [
        "docker-machine create",
        "-d #{driver}",
        "#{engine_options.join(' ')}",
        "#{name}"
      ].join(' ')
    end

    def engine_options
      options + default_engine_opts
    end

    def before_create
    end

    def after_create
      provision
    end

    def default_engine_opts
      []
    end

    def provision
    end
  end
end
