require 'pry'
require_relative './game_play_story'
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
    @curr_score = "\033[1;33m
    Current
    Score: #{self.current_score}\033[0;35m"
    @plnts_visit = "\033[1;33m
    Planets
    Visited: #{self.planets.length}\033[0;35m"
    @alns_encount = "\033[1;33m
    Aliens
    Indexed: #{self.aliens.length}\033[0;35m"

    puts unindent(<<-MORTYDEX)
    \033[0;35m
    .----------------------.
    |       \033[1;33mMortyDex\033[0;35m
    |
    |   \033[1;33mCURRENT SCORE: #{self.current_score}\033[0;35m
    |
    |  \033[1;33mPlanets Visited: #{self.planets.length}\033[0;35m
    |  \033[1;33mAliens Indexed: #{self.aliens.length}\033[0;35m
    |
    +----------------------+
    MORTYDEX
    # List Mortydex collection
    self.view_mortydex

    puts "\033[0;35m\ ------------------------\033[0m\ "
  end

  def main_mortydex
    self.mortydex
    # add an option to go back to Main Menu or to get more information
    self.mortydex_menu
    # self.more_info
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
    self.back_to_mortydex_menu
  end

  def back_to_mortydex_menu
    #select to go back to Mortydex from Alien Profile or main_menu
    puts <<-MENU
    1. Back to Mortydex
    2. Main Menu
    MENU

    input = gets.chomp
    case input
      when "1", 1
        self.main_mortydex
      when "2", 2
        return
        # returns to the main menu
      else
        back_to_mortydex_menu
        # loops back_to_mortydex_menu if input invalid
    end
  end

  def mortydex_menu
    #select more info or main_menu
    puts <<-MENU
    1. More Information
    2. Main Menu
    MENU

    input = gets.chomp
    case input
      when "1", 1
        self.more_info
      when "2", 2
        return
        # returns to the main menu
      else
        mortydex_menu
        # loops mortydex_menu if input invalid
    end
  end

  # HIGH SCORE BOARD
  def highscore
    system('clear')
    puts "-HIGH SCORES------------"
    puts ""
    puts " CURRENT SCORE: #{self.current_score}"
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
    # Stores score on login and end_game
    Score.create(user: self, user_score: self.current_score)
    # mortydex gets destroyed on login and end_game
    Mortydex.destroy_all
  end
  # END MORTYDEX RESET AND KEEP HIGHSCORE
end
