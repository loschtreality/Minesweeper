require_relative 'tile'

class Board
  def initialize(columns = 9, rows = 9, number_of_bombs = 10 )
    board = Array.new(rows) { Array.new(columns, nil) }
    @board = board_setup(board, number_of_bombs)
  end

  def board_setup(grid, number_of_bombs)
    tile_list = Tile.create_tiles(grid.length ** 2, number_of_bombs ).shuffle

    grid.map do |row|
      row.map do |col|
        col = tile_list.pop
      end
    end
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def reveal_tile(pos)
    self[pos].reveal
  end

  def uncover_tiles(pos)
    #for each pos, find the neighbors and send it to tile.set_neighbors
    #if tile at pos == 0 then go through each neighbor and reveal
    #if neighbor tile == 0 repeat
    #only reveal if not bomb or flagged: Stop if bomb, flagged, or n > 1
  end

  def get_neighbors(pos)
    surrounding = []
    row, col = pos
    surrounding << [row + 1, col + 1] if valid_position?([row + 1, col + 1])
    surrounding << [row + 1, col] if valid_position?([row + 1, col])
    surrounding << [row + 1, col - 1] if valid_position?([row + 1, col - 1])
    surrounding << [row, col - 1] if valid_position?([row, col - 1])
    surrounding << [row, col + 1] if valid_position?([row, col + 1])
    surrounding << [row - 1, col + 1] if valid_position?([row - 1, col + 1])
    surrounding << [row - 1, col] if valid_position?([row - 1, col])
    surrounding << [row - 1, col - 1] if valid_position?([row - 1, col - 1])
  end


  def valid_position?(pos)
    pos.all? { |n| n.between?(0,@board.size - 1) }
  end

end
