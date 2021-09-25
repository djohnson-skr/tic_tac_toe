# frozen_string_literal: true

# ensures that a players character is not a number
def character_selection(char)
  if char.match(/\d/)
    puts 'Please do not use numbers'
    false
  else
    true
  end
end

# creates a player
class Player
  attr_reader :name, :character

  def initialize(name, character)
    @name = name
    @character = character
  end
end

# creates a tic-tac-toe game
class Game
  @@player1_turn = true
  @@grid = %w[1 2 3 4 5 6 7 8 9]
  @@game_over = false

  def play_game(character1, character2)
    @p1_character = character1
    @p2_character = character2
    if @@player1_turn
      puts 'Player 1, your turn:'
      location = gets.chomp
      location = gets.chomp until check_input(location)
      location = gets.chomp until check_move(location)
      update_grid(location, character1)
      @@player1_turn = false
    else
      puts 'Player 2, your turn:'
      location = gets.chomp
      location = gets.chomp until check_input(location)
      location = gets.chomp until check_move(location)
      update_grid(location, character2)
      @@player1_turn = true
    end
    check_game
  end

  def check_input(input)
    if input.match(/\d/) && input.to_i.between?(1, 10)
      true
    else
      puts 'Please select a proper input.'
      false
    end
  end

  def check_move(location)
    if @@grid[location.to_i - 1].match(/\d/)
      true
    else
      puts 'Please select a valid position.'
      false
    end
  end

  def update_grid(location, character)
    @@grid[location.to_i - 1] = character
    puts ' '
    puts "    #{@@grid[0]} | #{@@grid[1]} | #{@@grid[2]}"
    puts '    ----------'
    puts "    #{@@grid[3]} | #{@@grid[4]} | #{@@grid[5]}"
    puts '    ----------'
    puts "    #{@@grid[6]} | #{@@grid[7]} | #{@@grid[8]}"
    puts ' '
    puts ' '
  end

  def game_finished
    @@grid.each do |num|
      num.match(/\d/) ? break : false
    end
  end

  def check_game
    if (@@grid[0] == @p1_character && @@grid[1] == @p1_character && @@grid[2] == @p1_character) ||
      (@@grid[3] == @p1_character && @@grid[4] == @p1_character && @@grid[5] == @p1_character) ||
      (@@grid[6] == @p1_character && @@grid[7] == @p1_character && @@grid[8] == @p1_character) ||
      (@@grid[0] == @p1_character && @@grid[3] == @p1_character && @@grid[6] == @p1_character) ||
      (@@grid[1] == @p1_character && @@grid[4] == @p1_character && @@grid[7] == @p1_character) ||
      (@@grid[2] == @p1_character && @@grid[5] == @p1_character && @@grid[8] == @p1_character) ||
      (@@grid[0] == @p1_character && @@grid[4] == @p1_character && @@grid[8] == @p1_character) ||
      (@@grid[2] == @p1_character && @@grid[4] == @p1_character && @@grid[6] == @p1_character)
      puts 'Player 1 has won the game!'
      @@game_over = true
    elsif (@@grid[0] == @p2_character && @@grid[1] == @p2_character && @@grid[2] == @p2_character) ||
      (@@grid[3] == @p2_character && @@grid[4] == @p2_character && @@grid[5] == @p2_character) ||
      (@@grid[6] == @p2_character && @@grid[7] == @p1_character && @@grid[8] == @p2_character) ||
      (@@grid[0] == @p2_character && @@grid[3] == @p2_character && @@grid[6] == @p2_character) ||
      (@@grid[1] == @p2_character && @@grid[4] == @p2_character && @@grid[7] == @p2_character) ||
      (@@grid[2] == @p2_character && @@grid[5] == @p2_character && @@grid[8] == @p2_character) ||
      (@@grid[0] == @p2_character && @@grid[4] == @p2_character && @@grid[8] == @p2_character) ||
      (@@grid[2] == @p2_character && @@grid[4] == @p2_character && @@grid[6] == @p2_character)
      puts 'Player 2 has won the game!'
      @@game_over = true
    elsif game_finished
      puts 'Its a tie!'
      @@game_over = true
    end
  end

  def self.game_over
    @@game_over
  end
end

puts 'This is a game of Tik-Tak-Toe!'

# player1 info
puts "\nPlease enter Player1's name:"
player1_name = gets.chomp
puts "Please enter #{player1_name}'s character:"
player1_character = gets.chomp
player1_character = gets.chomp until character_selection(player1_character)

# player2 info
puts "\nPlease enter Player2's name: "
player2_name = gets.chomp
puts "Please enter #{player2_name}'s character: "
player2_character = gets.chomp
player2_character = gets.chomp until character_selection(player2_character)

puts ' '
puts '    1 | 2 | 3'
puts '    ----------'
puts '    4 | 5 | 6'
puts '    ----------'
puts '    7 | 8 | 9'
puts ' '
puts 'Type the corresponding number to make your selection!'
puts ' '

player1 = Player.new(player1_name, player1_character)
player2 = Player.new(player2_name, player2_character)
tic_tak_toe = Game.new

tic_tak_toe.play_game(player1.character, player2.character) until Game.game_over
