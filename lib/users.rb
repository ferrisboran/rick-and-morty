require 'pry'
require_relative './stories'
class User < ActiveRecord::Base

  attr_reader :planets, :mortydex

  has_many :mortydexes
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
    You've been to #{self.planets.length} planets
    You've collected #{self.aliens.length} aliens
    -COLLECTION-------------
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
    # If input is between 0 - 9, convert it to an integer
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
    puts self.all_highscores[0...5]

    puts ""
    puts "------------------------"
  end

  # HELPER METHODS
  def all_highscores
    User.all.map do |user|
      " #{user.current_score} - #{user.name}"
    end.sort.reverse
    # Sorts the new array by total points in descending order
  end

  def current_score
    self.aliens.sum(:points)
    # Figure out how to avoid duplicate scores
  end
  # END HIGH SCORE BOARD

  def view_all_user_score
    self.all.each_with_index do |score, index|
      puts "#{index}: #{self.name} #{score.aliens.sum(:points)}"
    end
  end

end
