require_relative '../config/environment'
# require 'rest-client'
# require 'json'

# MVP
# - create a new user in database - done
# - save planet or alien data to database and associate it with user
# - view user's database

puts "Intro message. What's your username?"
username = gets.chomp
User.find_or_create_by(name: username)



# puts "HELLO WORLD"
