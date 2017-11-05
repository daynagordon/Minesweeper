require 'colorize'

class Tile  
  def initialize bomb = false
    @is_a_bomb = bomb
    @is_revealed = false
    @is_flagged = false
    @value = "*"
  end
  
  
  def reveal
    unless self.flagged?
      @value = (@is_a_bomb ? "B".colorize(:red) : "_")
      @is_revealed = true
    end
    @is_revealed
  end
  
  def set_value val
    unless self.bomb? || self.flagged?
      @value = val if self.revealed? && val.is_a?(Integer)
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
  
  def bomb?
    @is_a_bomb
  end
  
  def to_s
    "#{@value}"
  end
  
  def inspect
    "#{(@is_a_bomb ? "B" : @value)}"
  end
end