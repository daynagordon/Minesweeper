require_relative "tile"
require "byebug"

class Board
  
  def self.empty_grid width, length
    Array.new(width){Array.new(length)}
  end
  
  def initialize width = 4, length = 4
    @grid = Board.empty_grid( width, length )
    @bomb_pos = []
  end
  
  def populate num_bombs = 5
    @bomb_pos = rand_bomb_pos(num_bombs)
        
    (0...@grid.size).each do |row|
      (0...@grid[0].size).each do |col|
        @grid[row][col] = Tile.new @bomb_pos.include?([row,col])
      end
    end
    self
  end
  
  def toggle_flag pos
    self[pos].toggle_flag
  end
  
  def render
    render_string = ["  #{(0...@grid.size).to_a.join(" ")}"]
    @grid.transpose.each_with_index do |row, idx|
      render_string << "#{idx} #{row.join(" ")}"
    end
    puts render_string.join("\n")
  end

  def adjacent_pos pos
    x, y =  pos
    adjacents = []
    (x-1..x+1).each do |row|
      next if row < 0 || row >= @grid.size
      
      (y-1..y+1).each do |col|
        next if col < 0 || col >= @grid.size
        
        next if pos == [row, col]
        
        adjacents << [row, col]
      end
    end
    adjacents
  end
  
  def reveal_adjacents adjacents
    adjacents.each do |current|
      next if @bomb_pos.include?( current ) || self[current].revealed?
      
      self.reveal( current )
    end
    nil
  end
  
  def reveal pos
    unless self[pos].flagged? || self[pos].bomb?
      adjacents = adjacent_pos( pos )
      bomb_count = (@bomb_pos & adjacents).size
      
      self[pos].reveal
      
      if bomb_count == 0
        reveal_adjacents adjacents
      else
        self[pos].set_value bomb_count
      end
    end
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