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

  def find_card_neighbors
    @board.each_with_index do |row,row_idx|
      row.each_index do |col|
        neighbor_list = get_neighbors([row_idx, col]).map { |coord| self[coord] }
        self[[row_idx,col]].set_neighbors(neighbor_list)
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
    byebug
    current_tile = self[pos]
    current_tile.set_neighbors(get_neighbors(pos))

    current_tile.reveal
    return false if current_tile.is_bomb

    if current_tile.neighbor_bomb_count.zero?
      current_tile.neighbors.each do |neighbor|
        display_neighbor(neighbor)
      end
    end
  end

  def display_neighbor(pos)
    unless self[pos].is_bomb || self[pos].flagged
      uncover_tiles(pos)
    end
  end

  def get_neighbors(pos)
    surrounding = []
    row, col = pos

    [[1, -1], [-1, 1]].each do |op|
      surrounding << [row + op.first, col + op.last]
      surrounding << [row + op.first, col ]
      surrounding << [row , col + op.last]
      surrounding << [row + op.first, col - op.last]
    end

    surrounding.select { |pos| valid_position?(pos) }.sort
  end

  def display
    puts "  #{(0...@board.count).to_a.join("   ")}"
    @board.each_with_index.map do |row, i|
      row.map do |col, i|
         "#{col.display_value} "
      end.unshift("#{i}").join(" ")
    end.join("\n")
    #display board through tile.display_value
  end



  def valid_position?(pos)
    pos.all? { |n| n.between?(0,@board.size - 1) }
  end

end
