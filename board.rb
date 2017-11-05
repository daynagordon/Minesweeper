class Board
  
  def self.empty_grid width, length = nil
    Array.new(width){Array.new(length | width)}
  end
  
  def initialize width = 5, length = 5
    @grid = grid
  end
  
  def populate num_bombs = 5
  end
  
  def [] pos
    x,y = pos
    @grid[x][y]
  end
  
  def []= pos, val
    x,y = pos
    @grid[x][y] = val
  end
  
  
end