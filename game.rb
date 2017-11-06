require_relative 'board'

class Game
  
  def initialize width = 4, length = 4
    @board = Board.new(width, length)
    @width = width
    @length = length
  end
  
  def run
    @board.populate
    over = @board.over?
    
    until over
      @board.render
      
      option, pos = self.get_input
      case option
      when 'r', 'R'
        @board.reveal( pos )
        over = @board.over?
      when 'F', 'f'
        @board.toggle_flag( pos )
        over = @board.over?
      when 'q'
        over = self.quit
      # when
        # over = self.save
      end
      system "clear"
    end
    
    @board.render
    if @board.lost?
      puts "Bad luck, that."
    elsif @board.won?
      puts "Way to go, champ!"
    else
      puts "Goodbye!"
    end
  end
  
  def quit
    print "Are you sure? > "
    input = gets.chomp
    return input[0] == 'y'
  end
  
  def get_input
    puts "Please enter your choice as option, x coordinate, y coordinate"
    puts "Enter q to quit or s to save"
    print "e.g. \"r,x,y\" or \"f,x,y\" or \"q\" > "
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
    if ['r','R','f','F'].include?( input.first ) 
      return valid_pos?( input.last )
    else
      return ['q','Q','s','S'].include?( input.first )
    end
  end
  
  def valid_pos? pos
    x, y = pos
    (0...@width).cover?(x) && (0...@length).cover?(y) 
  end
  
  def over?
    @board.lost? || @board.won?
  end
end