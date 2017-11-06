require_relative 'board'

class Game
  
  def initialize width = 4, length = 4
    @board = Board.new(width, length)
    @width = width
    @length = length
  end
  
  def run
    @board.populate
    
    until @board.over?
      @board.render
      
      option, pos = self.get_input
      case option
      when 'r', 'R'
        @board.reveal( pos )
      when 'F', 'f'
        @board.toggle_flag( pos )
      end
    end
    
    @board.render
    if @board.lost?
      puts "Bad luck, that."
    else
      puts "Way to go, champ!"
    end
  end
  
  def get_input
    puts "Please enter your choice as option,x coordinate, y coordinate"
    print "e.g. \"r,x,y\" or \"f,x,y\" > "
    input = parse_input(gets.chomp)
    
    until valid? input
      begin
        puts "Check your formatting: \"r,x,y\" or \"f,x,y\""
        input = parse_input(gets.chomp)
      rescue => error
        puts "#{error}"
        print "> "
      end
    end
    input
  end
  
  def parse_input input
    input = input.split(",")
    option  = (input.size == 2 ? 'r' : input.shift)
    [option, input.map{ |char| Integer(char) }]
  end
  
  def valid? input
    ['r','R','f','F'].include?( input.first ) && valid_pos?( input.last )
  end
  
  def valid_pos? pos
    x, y = pos
    (0...@width).cover?(x) && (0...@length).cover?(y) 
  end
  
  def over?
    @board.lost? || @board.won?
  end
end