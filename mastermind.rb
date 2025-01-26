require 'colorize'

class Mastermind

  COLORS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow,
    "O" => :light_red,
    "P" => :magenta
  }

  def initialize
    @code = Array.new(4) {COLORS.keys.sample}
    @attempts = 0

    puts "Welcome to Mastermind. Try to guess the secret 4-color code."
    display_available_colors
    puts "Enter your guess using the first letter of each color."
    puts "You have 12 attempts to crack the code."
  end

  def play
    while @attempts < 12
      print "\nAttempt ##{@attempts+1}: "
      guess = get_valid_guess
      @attempts += 1

      if guess == @code
        puts "Congratulations! You successfully cracked the code: #{format_guess(guess)}"
        return
      end

      feedback = give_feedback(guess)
      puts "Feedback: #{feedback}"
    end

    puts "You lose. The code was #{format_guess(@code)}"
  end

  private

  def display_available_colors
    print "Available colors: "
    COLORS.each { |letter, color| print letter.colorize(color) + " " }
  end

  def get_valid_guess
    loop do 
      input = gets.chomp.upcase.chars
      return input if valid_guess?(input)
      puts "Invalid input! Enter 4 colors from: "
      display_available_colors
    end
  end

  def valid_guess?(guess)
    guess.length == 4 && guess.all? { |char| COLORS.keys.include?(char) }
  end

  def format_guess(guess)
    guess.map { |letter| letter.colorize(COLORS[letter]) }.join(" ")
  end

  def give_feedback(guess)
    exact_matches = guess.each_index.count { |i| guess[i] == @code[i] }
    remaining_code = @code.reject.with_index { |color, i| color == guess[i] }
    remaining_guess = guess.reject.with_index { |color, i| color == @code[i] }
    color_matches = remaining_guess.count { |color| remaining_code.include?(color) }
    "🟢" * exact_matches + "🟡" * color_matches
  end

end

Mastermind.new.play