
module Marty
  class Grid < Clamp::Command

    autoload :Base, 'marty/nodes/base'
    autoload :Create, 'marty/grid/create'

    subcommand "create", "create a new grid", Marty::Grid::Create
  end
end
