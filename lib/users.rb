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
    puts "-MORTYDEX---------------"
    puts "You've been to #{self.planets.length} planets"
    puts "You've collected #{self.aliens.length} aliens"
    puts "-COLLECTION-------------"
    self.view_mortydex
    puts "------------------------"
    puts "Learn more by pressing 1 - #{self.aliens.length}"
    # binding.pry
    input = gets.chomp
    mortydex_input(input)
  end

  # HELPER METHODS
  def view_mortydex
    self.aliens.each.with_index(1) do |alien, index|
      puts "#{index}: #{alien.name} (#{alien.planet.name})"
    end.uniq
  end

  def mortydex_input(input)
    new_input = input.to_i-1
    if !alien_profile(new_input)
      puts "Try again"
    else
      alien_profile(new_input)
    end
  end

  def alien_profile(new_input)
    system('clear')
    puts <<-PROFILE

    Name: #{self.aliens[new_input].name}
    ------------------------
    Status: #{self.aliens[new_input].status}
    Species: #{self.aliens[new_input].species}
    Planet Origin: #{self.aliens[new_input].planet.name}
    Points: #{self.aliens[new_input].points}
    ------------------------
    PROFILE
    puts ""
    mortydex_menu
  end

  def mortydex_menu
    puts "Back to Mortydex (Y/N)"
    input = gets.chomp
    downcase_input = input.downcase

    case downcase_input
    when "y", "yes"
        self.mortydex
    when "n", "no"
        # puts "Go back to the Main Menu? (Y/N)"
        # main_menu_input = gets.chomp
        # downcase_menu_input = main_menu_input.downcase
      # break
        # case downcase_menu_input
        #   when "y", "yes"
        #
        #   when "n", "no"
        #     self.mortydex_menu
        #   else
        #     puts "Press Y or N!"
        # end
      else
        puts "Press Y or N!"
    end
  end
  # END MORTYDEX

  def current_score
    self.aliens.sum(:points)
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
