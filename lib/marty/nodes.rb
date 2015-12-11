module Marty
  class Nodes < Clamp::Command
    DRIVERS=%w|virtualbox amazonec2 digitalocean vultr|

    subcommand "create", "create a new grid", Marty::Nodes::Create
    subcommand ["rm", "remove", "destroy"], "create a new grid" do
      parameter "names ...", "name of the machine to remove", attribute_name: :names
      def execute
        system("docker-machine rm #{names.join(' ')}")
      end
    end

    subcommand "ls", "list machines" do
      option ["-d", "--driver"], "filter for driver", "<#{DRIVERS.join('|')}>"
      parameter "name", "name of the grid", required: false

      def execute
        cmd="docker-machine ls"
        cmd << " --filter driver=#{driver}" if DRIVERS.include?(driver)
        cmd << " --filter swarm=#{name}" if name
        system(cmd)
      end
    end
  end
end
