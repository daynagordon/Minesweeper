require_relative 'game'
require 'yaml'

if __FILE__ == $PROGRAM_NAME
  
  filename = ARGV.shift
  
  easy = {
    num_bombs: 5,
    width: 9,
    length: 9
  }
  
  if filename
    g = YAML.load(File.read(filename))
  else
    g = Game.new easy  
  end
  
  g.run
end