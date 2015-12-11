module Marty
  module Grid
    autoload :Create, 'marty/grid/create'
  end

  module Nodes
    DRIVERS=%w|virtualbox amazonec2 digitalocean vultr|

    autoload :Base, 'marty/nodes/base'
    autoload :Create, 'marty/nodes/create'
  end

  class MainCommand < Clamp::Command
    subcommand "create", "Create things" do
      subcommand "grid", "Create a new grid", Marty::Grid::Create
      subcommand "node", "Create a new node", Marty::Nodes::Create
      subcommand "foo", "test" do
        parameter "options ...", "optiosn", attribute_name: :opts

        def execute
          ENV['FOO']="bar"
          system("echo $FOO")
          puts @opts.join(' ')
        end
      end
    end

    subcommand "create", "create a new grid", Marty::Nodes::Create

    subcommand ["rm", "remove", "destroy"], "create a new grid" do
      parameter "names ...", "name of the machine to remove", attribute_name: :names
      def execute
        system("docker-machine rm #{names.join(' ')}")
      end
    end

    subcommand "ls", "list machines" do
      option ["-d", "--driver"], "filter for driver", "<#{Nodes::DRIVERS.join('|')}>"
      parameter "name", "name of the grid", required: false

      def execute
        cmd="docker-machine ls"
        cmd << " --filter driver=#{driver}" if Nodes::DRIVERS.include?(driver)
        cmd << " --filter swarm=#{name}" if name
        system(cmd)
      end
    end
  end
end
