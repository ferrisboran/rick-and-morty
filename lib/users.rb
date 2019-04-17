require 'pry'
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
    if self.aliens.length > 1
      puts "Learn more by pressing 1 - #{self.aliens.length}"
      input = gets.chomp
      mortydex_input(input)
    end
    ""
  end

  # HELPER METHODS
  def unindent(s)
    s.gsub(/^#{s.scan(/^[ \t]+(?=\S)/).min}/, '')
  end

  def view_mortydex
    # Creates an index for our self.aliens array that can be referenced for selection
    self.aliens.each.with_index(1) do |alien, index|
      puts "#{index}: #{alien.name} (#{alien.planet.name})"
    end.uniq
  end

  def mortydex_input(input)
    # Converts input to a string and subtracts one so it aligns with index numbers
    new_input = input.to_i-1

    # figure out the last number in the array, if it's outside of it, say try again
    if !alien_profile(new_input)
      puts "Try again"
    else
      alien_profile(new_input)
    end
  end

  def alien_profile(new_input)
    system('clear')
    # ALIEN PROFILE BLOCK
    puts unindent(<<-PROFILE)
    Name: #{self.aliens[new_input].name}
    ------------------------
    Status: #{self.aliens[new_input].status}
    Species: #{self.aliens[new_input].species}
    Planet Origin: #{self.aliens[new_input].planet.name}
    Points: #{self.aliens[new_input].points}
    ------------------------
    PROFILE
    puts ""
    # Asks to return to Mortydex
    mortydex_menu
  end

  def mortydex_menu
    puts "Back to Mortydex (Y/N)"
    input = gets.chomp
    downcase_input = input.downcase

    case downcase_input
      when "y", "yes"
        # Returns to Mortydex
        self.mortydex
      when "n", "no"
        puts "Go back to the Main Menu? (Y/N)"
        main_menu_input = gets.chomp
        downcase_menu_input = main_menu_input.downcase
        case downcase_menu_input
          when "y", "yes"
          when "n", "no"
            self.mortydex_menu
          else
            puts "Press Y or N!"
        end
      else
        puts "Press Y or N!"
    end
  end
  # END MORTYDEX

  def current_score
    self.aliens.sum(:points)
    # Figure out how to avoid duplicate scores
  end

end
