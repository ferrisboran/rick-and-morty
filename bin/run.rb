require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'

# MVP
# - create a new user in database - done
# - save planet or alien data to database and associate it with user - done
# - view user's database

# INTRO
puts "Intro message. What's your username?"
username = gets.chomp

# LOGIN
@current_user = User.find_or_create_by(name: username)
Mortydex.find_or_create_by(user_id: @current_user.id)

# PLANETS
planets = Rickmorty::Location.new
planets_db = planets.all.each do |planet|
  Planet.find_or_create_by(name: planet["name"])
  # binding.pry
end

# ALIENS
@random_planet = Planet.all.sample
aliens = Rickmorty::Character.new
aliens_db = aliens.all.each do |character|
  # binding.pry
  name = character["name"]
  species = character["species"]
  status = character["status"]
  home_id = Planet.find_by(name: character["origin"]["name"])
  points = character["name"].length

  # if planet exist, do this:
  if !!home_id
    Alien.find_or_create_by(
      name: name.nil? ? "No name" : name, status: status.nil? ? "Status unknown" : status, species: species.nil? ? "Species not identified" : species, planet_id: character["location"].length == 0 ? @random_planet.id : home_id.id, points: points.nil? ? 0 : points
    )
  end
  # if !!home_id
  #   Alien.find_or_create_by(name: name.nil? ? "No name" : name, status: status.nil? ? "Status unknown" : status, species: species.nil? ? "Species not identified" : species, planet_id: home_id.nil? ? "No home" : home_id.id, points: points.nil? ? 0 : points)
  # end

end

######menu

# alien = Alien.all.where("planet_id = ?", @random_planet.id)
@alien = Alien.all.where("planet_id = ?", 12).sample

# SELECT A PLANET
puts "choose:
      1.select planet
      2.Go to a planet
      3.view mortydex
      4.Go home
      5.View high scores"

user_input = gets.chomp

# INSTANCE METHODS
def save_alien
  puts "Save alien? yes/no "
  while yn = gets.chomp
    case yn.downcase
    when "yes"
      puts "Enter name: "
      name = gets.chomp
      puts "Species? "
      species = gets.chomp
      @current_user.aliens << Alien.find_or_create_by(name: name, status: "Alive", species: species, planet_id: @random_planet.id, points: name.length)
      break
    when "no"
      puts "Fine! Whatever!"
      break
    else
      puts "YES or NO! It's not that hard!"
    end
  end
end

def collect_alien
  puts "You bump into #{@alien.name}"
  puts "Save them to your Mortydex? (Yes/No)"
  while yn = gets.chomp
    case yn.downcase
    when "yes"
      @current_user.aliens << Alien.find_or_create_by(name: @alien.name, status: @alien.status, species: @alien.species, planet_id: @alien.planet_id, points: @alien.name.length)
      puts "#{@alien.name}: Awesome, see you soon!"
      break
    when "no"
      puts "#{@alien.name}: Fine! Whatever!"
      break
    else
      puts "YES or NO! It's not that hard!"
    end
  end
end

def view_mortydex
  @current_user.aliens.map do |alien|
    puts "#{alien.name} (#{alien.planet.name})"
  end.uniq
end

# SELECT A PLANET INPUT
case user_input
  when "1"
    puts @random_planet.name
    puts @alien.nil? ? save_alien : collect_alien
  when "3"
    view_mortydex
end




binding.pry
