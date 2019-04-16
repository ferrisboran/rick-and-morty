require 'rest-client'
require 'json'
require 'pry'

charaters = JSON.parse(RestClient.get("https://rickandmortyapi.com/api/character/"))

charaters.each do |x|
  puts x
  binding.pry
end
