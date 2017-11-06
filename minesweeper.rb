require_relative 'game'

if __FILE__ == $PROGRAM_NAME
  easy = {
    num_bombs: 5,
    width: 9,
    length: 9
  }
  g = Game.new easy
  g.run
end