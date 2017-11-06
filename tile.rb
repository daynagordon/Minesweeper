require 'colorize'
require 'yaml'

class Tile  
  def initialize options = {}
    defaults = {
      bomb: false,
      revealed: false,
      flagged: false,
      value: '*'
    }
    options = defaults.merge(options)
    
    @is_a_bomb = options[:bomb]
    @is_revealed = options[:revealed]
    @is_flagged = options[:flagged]
    @value = options[:value]
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
    @value
  end
  
  def toggle_flag
    unless @is_revealed
      @is_flagged = !@is_flagged
      @value = @is_flagged ? "F".colorize(:blue) : "*"
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
    {
      bomb: @is_a_bomb,
      revealed: @is_revealed,
      flagged: @is_flagged   
    }.to_s
  end
end 