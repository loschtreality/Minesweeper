class Tile
  attr_reader :is_bomb, :neighbors, :flagged, :display_value

  def initialize(is_bomb = false)
    @hidden = true
    @is_bomb = is_bomb
    @flagged = false
    @display_value = "[]"
  end

  def self.create_tiles(number_tiles, number_bombs)
    tile_list = []
    number_bombs.times do
      tile_list << Tile.new(true)
    end

    (number_tiles - number_bombs).times do
      tile_list << Tile.new
    end

    tile_list
  end

  def reveal
    @hidden = false
    # display bomb_count or display bomb
    @display_value = @is_bomb ? "*" : "#{neighbor_bomb_count}"
  end

  def flag
    @flagged = true
    @display_value = "?"
  end

  def set_neighbors(list_of_neighbors)
    @neighbors = list_of_neighbors
  end

  def neighbor_bomb_count
    @neighbors.count { |neighbor| neighbor.is_bomb }
  end


end
