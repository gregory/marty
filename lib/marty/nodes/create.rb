module Marty
  class Nodes::Create < Nodes::Base
    parameter "name", "name of the grid"

    option ['-j', '--join'], 'grid name', "join a grid", attribute_name: :grid_name, required: true
    option '--master', :flag, 'master of the grid', default: false

    protected

    def default_engine_opts
     super + [
        "--engine-label type=node",
        "--engine-opt dns-search=service.consul",
        "--engine-opt dns=172.17.0.1",
        "--engine-opt dns=8.8.8.8",
        "--engine-opt 'cluster-store=consul://#{kv_ip}:8500'",
        "--engine-opt 'cluster-advertise=eth0:2376'",
        "--swarm",
        "--swarm-discovery 'consul://#{kv_ip}:8500'"
      ].tap do |array|
        array.push("--swarm-master --swarm-strategy spread") if master?
      end
    end

    def kv_ip
      ret, _ = Open3.capture2("docker-machine ip #{grid_name}")
      ret.strip
    end

    def ip
      ret, _ = Open3.capture2("docker-machine ip #{name}")
      ret.strip
    end

    def provision
      # NOTE: ip could be: #{grid_name}.node.consul
      # NOTE: we could use consul-template on kv to run docker-compose on the new node
      # joining the cluster
      Open3.popen2e({"CONSUL_IP" => kv_ip, "NODE_IP" => ip}, "eval $(docker-machine env #{name}) && docker-compose -f #{compose_file} up -d") do |stdin, stdout|
        while line = stdout.gets
          puts line
        end
      end
    end

    def compose_file
      "#{ROOT_PATH}/composes/node.yml"
    end
  end
end
