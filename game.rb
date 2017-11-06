require_relative 'board'

class Game
  
  def initialize options = {}
    defaults = {
      num_of_bombs: 5,
      width: 4,
      length: 4
    }
    options = defaults.merge(options)
    @board = Board.new(options)
  end
  
  def run
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
      when 'q', 'Q'
        over = self.quit
      when 's', 'S'
        over = self.save
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
    print "Would you like to save your game? > "
    input = gets.chomp
    return true unless input[0] == 'y'
    
    self.save
  end
  
  def save
    print "Please enter a filename > "
    filename = gets.chomp
    
    file = File.open(filename, "w")
    file.puts self.to_yaml
    file.close
    true
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
    x_max, y_max = @board.size
    (0...x_max).cover?(x) && (0...y_max).cover?(y) 
  end
  
  def over?
    @board.lost? || @board.won?
  end
end