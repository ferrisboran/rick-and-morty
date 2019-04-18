require 'pry'
require_relative './stories'
class User < ActiveRecord::Base

  attr_reader :planets, :mortydex

  has_many :mortydexes
  has_many :scores
  has_many :aliens, through: :mortydexes

  def planets
    self.aliens.map do |alien|
      alien.planet
    end.uniq
  end

  # MORTYDEX
  def mortydex
    system('clear')

    puts unindent(<<-MORTYDEX)
    -MORTYDEX---------------
    Total Points: #{self.current_score}

    You've visited to #{self.planets.length} planets
    You've encountered #{self.aliens.length} aliens
    -ENCOUNTERS-------------
    MORTYDEX
    # List Mortydex collection
    self.view_mortydex
    puts "------------------------"
  end

  def main_mortydex
    self.mortydex
    self.more_info
  end

  # HELPER METHODS

  def more_info
    if self.aliens.length >= 1
      if self.aliens.length == 1
        puts "Learn more by pressing #{self.aliens.length}"
      else
        puts "Learn more by pressing 1 - #{self.aliens.length}"
      end
      # Valid the input to ensure it's within parameters
      input = self.get_valid_input((1..self.aliens.length).to_a)
      alien_profile(input-1)
      # Using `input-1` to align with array index
    end
  end

  def unindent(string)
    # Removes indentations
    string.gsub(/^#{string.scan(/^[ \t]+(?=\S)/).min}/, '')
  end

  def view_mortydex
    # Creates an index for our self.aliens array that can be referenced for selection
    self.aliens.each.with_index(1) do |alien, index|
      puts "#{index}: #{alien.name} (#{alien.planet.name})"
    end.uniq
  end

  def input
    input = gets.chomp
    # If input is between 0 - 100, convert it to an integer
    ("0".."100").to_a.include?(input) ? input.to_i : input
  end

  def get_valid_input(options)
    # SHOUTOUT TO JEFF/JACOB FOR SHARING THEIR VALIDATION METHOD
    ans = self.input
    until options.include?(ans)
      if ans.to_i <= 1 && self.aliens.length <= 1
        # if input <= 1 and the current aliens array <= 1
        puts "Please choose an option #{self.aliens.length}."
      elsif self.aliens.length <= 1
        # if aliens array <= 1
        puts "Please choose an option #{self.aliens.length}."
      else
        puts "Please choose an option in #{options}."
      end
      ans = self.input
    end
    ans
  end

  def alien_profile(input)
    system('clear')
    # ALIEN PROFILE BLOCK
    puts unindent(<<-PROFILE)
    Name: #{self.aliens[input].name}
    Points: #{self.aliens[input].points}
    ------------------------
    Status: #{self.aliens[input].status}
    Species: #{self.aliens[input].species}
    Planet Origin: #{self.aliens[input].planet.name}
    ------------------------
    PROFILE
    puts ""
    # Ask to return to Mortydex
    mortydex_menu
  end

  def mortydex_menu
    puts "Back to Mortydex [y/n]"
    # Valid the input to ensure it's within parameters
    input = self.get_valid_input(['y', 'n'])
    case input
      when "y", "yes"
        # Returns to Mortydex
        self.main_mortydex
      when "n", "no"
        return
        # Returns to Main Menu
    end
  end
  # END MORTYDEX

  # HIGH SCORE BOARD
  def highscore
    system('clear')
    puts "-HIGH SCORES------------"
    puts ""
    puts " TOTAL - NAME"
    puts ""

    #see a list of users high scores
    puts self.all_highscores

    puts ""
    puts "------------------------"
  end

  # HELPER METHODS
  def create_scores
    Score.create(user: self, user_score: self.current_score)
  end

  def all_highscores
    # breaks if User was removed, requires a reset in Score
    # using ActiveRecord method to sort by user_score before mapping to keep order.
    Score.all.order("user_score DESC LIMIT 5").map do |score|
      " #{score.user_score} - #{score.user.name}"
    end
    # Sorts the new array by total points in descending order
  end

  def current_score
    self.aliens.sum(:points)
  end
  # END HIGH SCORE BOARD

  # MORTYDEX RESET AND KEEP HIGHSCORE
  def reset_mortydex
    # Stores score on login
    Score.create(user: self, user_score: self.current_score)
    # mortydex gets destroyed on login and end_game
    Mortydex.destroy_all
  end
  # END MORTYDEX RESET AND KEEP HIGHSCORE
end
