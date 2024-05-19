require './base_player.rb'

class YourPlayer < BasePlayer
  def initialize(game:, name:)
    @visited = Set.new
    @queue = []
    @path = []
    super
  end

  def next_point(time:)
    if @path.empty?
      # Starting point
      start_point = { row: 0, col: 0 }
      @path << start_point
      @visited << start_point
      return start_point
    end

    current_point = @path.last

    # Check if all nodes have been visited
    if @visited.size == grid.size * grid.size
      return nil
    end

    # Add neighbors to the queue
    grid.neighbors({row: current_point[:row], col: current_point[:col]}).each do |neighbor|
      if !@visited.include?(neighbor)
        @queue << neighbor
        @visited << neighbor
        @path << neighbor
      end
    end

    # Remove the first node from the queue
    next_point = @queue.shift

    # Return the next point to visit
    next_point
  end

  def grid
    game.grid
  end
end