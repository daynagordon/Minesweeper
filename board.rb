require_relative "tile"
require "byebug"

class Board
  
  def self.empty_grid width, length
    Array.new(width){Array.new(length)}
  end
  
  def initialize width = 4, length = 3
    @grid = Board.empty_grid( width, length )
    @bomb_pos = []
  end
  
  def populate num_bombs = 5
    @bomb_pos = rand_bomb_pos(num_bombs)
        
    (0...@grid.size).each do |row|
      (0...@grid.size).each do |col|
        @grid[row][col] = Tile.new @bomb_pos.include?([row,col])
      end
    end
    self
  end
  
  def toggle_flag pos
    self[pos].toggle_flag
  end
  
  def [] pos
    x,y = pos
    @grid[x][y]
  end
  
  def []= pos, val
    x,y = pos
    @grid[x][y] = val
  end
  
  private
  
  def rand_bomb_pos num_bombs = 5
    bombs = []
    until bombs.size == num_bombs do 
      pos = [rand(0...@grid.size), rand(0..@grid[0].size)]
      bombs << pos unless bombs.include?(pos)
    end
    bombs
  end
end