require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'

# MVP
# - create a new user in database - done
# - save planet or alien data to database and associate it with user
# - view user's database

# INTRO
puts "Intro message. What's your username?"
username = gets.chomp

# LOGIN
current_user = User.find_or_create_by(name: username)
Mortydex.find_or_create_by(user_id: current_user.id)

# PLANETS
planets = Rickmorty::Location.new
planets_db = planets.all.each do |planet|
  Planet.find_or_create_by(name: planet["name"])
  # binding.pry
end

# ALIENS
aliens = Rickmorty::Character.new
aliens_db = aliens.all.each do |character|
  # binding.pry
  name = character["name"]
  species = character["species"]
  status = character["status"]
  home_id = Planet.find_by(name: character["origin"]["name"])
  points = character["name"].length

  if !!home_id
    Alien.find_or_create_by(name: name.nil? ? "No name" : name, status: status.nil? ? "Status unknown" : status, species: species.nil? ? "Species not identified" : species, planet_id: home_id.nil? ? "No home" : home_id.id, points: points.nil? ? 0 : points)
  end
end

binding.pry
