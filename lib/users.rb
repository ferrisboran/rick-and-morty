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
      alien_profile(input)
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
    # If input is between 0 - 9, convert it to an integer then subtract one to match array index items
    ("0".."9").to_a.include?(input) ? input.to_i - 1 : input
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
    # Asks to return to Mortydex
    mortydex_menu
  end

  def mortydex_menu
    puts "Back to Mortydex (Y/N)"
    downcase_input = input.downcase
    case downcase_input
      when "y", "yes"
        # Returns to Mortydex
        self.main_mortydex
      when "n", "no"
        puts "Go back to the Main Menu? (Y/N)"
        downcase_menu_input = input.downcase
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

  def visit_planet
    five_planets = Planet.display_five_planets
    puts "Choose a Planet:"
    input = gets.chomp
    planet_input = input.to_i-1
    while planet_input
      case planet_input
      when "1","2","3,","4","5"
        Planet.find_by(name: five_planets[planet_input])
        break
      else
        "Pick again"
      end
    end
    # .where(["name = ?", planet.id])
  end

end
