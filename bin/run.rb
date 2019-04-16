require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'

# MVP
# - create a new user in database - done
# - save planet or alien data to database and associate it with user
# - view user's database

# locations = []
# pages = [1..4]

# LOCATIONS API
locations = RestClient.get('https://rickandmortyapi.com/api/location/?page=1')
parsed = JSON.parse(locations)

# INTRO
puts "Intro message. What's your username?"
username = gets.chomp

# LOGIN
current_user = User.find_or_create_by(name: username)
Mortydex.find_or_create_by(user_id: current_user.id)

# PLANETS
planets = parsed["results"].select do |data|
  data["type"] == "Planet"
end

planets_db = planets.each do |planet|
  Planet.find_or_create_by(name: planet["name"])
end

# ALIENS
aliens = planets.map do |planet|
  planet["residents"].map do |resident|
    JSON.parse(RestClient.get(resident))["name"]
    # binding.pry
  end
end


binding.pry


# puts "HELLO WORLD"
