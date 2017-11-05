require 'colorize'

class Tile
  
  attr_reader :is_a_bomb
  
  def initialize bomb = false
    @is_a_bomb = bomb
    @is_revealed = false
    @is_flagged = false
    @value = "*"
  end
  
  
  def reveal adjacent_value = "_"
    unless self.flagged?
      @value = (@is_a_bomb ? "B".colorize(:red) : adjacent_value)
      @is_revealed = true
    end
  end
  
  def toggle_flag
    unless @is_revealed
      @is_flagged = !@is_flagged
      @value = "F".colorize(:blue) if @is_flagged
    end
    @is_flagged
  end
  
  def flagged?
    @is_flagged
  end
  
  def revealed?
    @is_revealed
  end
  
  def to_s
    "#{@value}"
  end
  
  def inspect
    "#{(@is_a_bomb ? "B" : @value)}"
  end
end