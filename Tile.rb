class Tile
  
  attr_reader :bomb, :revealed, :flagged
  def initialize bomb
    @bomb = bomb
    @revealed = false
    @flagged = false
  end
  
  
  def reveal
    @revealed = true
  end
  
  def toggle_flag
    @flagged = !@flagged
  end
end