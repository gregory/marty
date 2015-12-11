require 'marty/nodes/base'
module Marty
  class Grid::Create < Nodes::Base
    parameter "name", "name of the grid"

    def default_engine_opts
      [
        "--engine-label type=grid",
        "--engine-opt dns=172.17.0.1",
        "--engine-opt dns=8.8.8.8",
      ]
    end

    def compose_file
      "#{ROOT_PATH}/composes/grid.yml"
    end

    def provision
      Open3.popen2e({"NODE_IP" => kv_ip, "HOSTNAME" => name}, "eval $(docker-machine env #{name}) && docker-compose -f #{compose_file} up -d") do |stdin, stdout|
        while line = stdout.gets
          puts line
        end
      end
    end

    def kv_ip
      ret, _ = Open3.capture2("docker-machine ip #{name}")
      ret.strip
    end

  end
end
