require_relative 'game'

if __FILE__ == $PROGRAM_NAME
  g = Game.new 9, 9
  g.run
end