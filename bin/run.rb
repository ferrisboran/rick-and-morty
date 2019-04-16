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

locations = RestClient.get('https://rickandmortyapi.com/api/location/?page=1')
parsed = JSON.parse(locations)

puts "Intro message. What's your username?"
username = gets.chomp
User.find_or_create_by(name: username)

planets = parsed["results"].select do |data|
  data["type"] == "Planet"
end

planets.each do |planet|
  Planet.create(name: planet["name"])
end

binding.pry


# puts "HELLO WORLD"
