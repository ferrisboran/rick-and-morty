require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'

# MVP
# - create a new user in database - done
# - save planet or alien data to database and associate it with user - done
# - view user's database

# INTRO & LOGIN
puts "Please login"
print "Username: "
username = gets.chomp

# POPULATE ALIEN & PLANET TABLE IF FIRST TIME

aliens = []
i = 1
if !User.find_by(name: username)
  puts "Please wait"
  while i < 100
    aliens << (JSON.parse(RestClient.get("https://rickandmortyapi.com/api/character/#{i}").body))
    i += 1
  end
else
  puts returning_user_story(username)
end

# PLANETS CREATED FROM ALIEN
aliens.each do |alien|
  if !!alien["origin"]["name"]
    planets = Planet.find_or_create_by(name:alien["origin"]["name"])
    Alien.find_or_create_by(name: alien["name"], status: alien["status"], species: alien["species"], planet_id: planets.id, points: alien["name"].length)
  end
end

@current_user = User.find_or_create_by(name: username)
Mortydex.find_or_create_by(user_id: @current_user.id)

# MAIN MENU
main_menu = "Choose Your Next Move:
      1. Select a Planet
      2. Go to a Random Planet
      3. View Mortydex
      4. View Current Score
      5. Go Home(Quit)"

puts main_menu

# INSTANCE METHODS
def create_alien
  puts "It looks like this is a new planet! Create and Save the new alien? yes/no "
  while yn = gets.chomp
    case yn.downcase
    when "yes","y"
      puts "Enter name: "
      name = gets.chomp
      puts "Species? "
      species = gets.chomp
      @current_user.aliens << Alien.find_or_create_by(name: name, status: "Alive", species: species, planet_id: @random_planet.id, points: name.length)
      break
    when "no","n"
      puts "Fine! Whatever!"
      break
    else
      puts "YES or NO! It's not that hard!"
    end
  end
end

def collect_alien
  current_alien = @alien.sample
  puts ""
  puts "You bump into #{current_alien.name}"
  puts "Save them to your Mortydex? (Yes/No)"
  while yn = gets.chomp
    case yn.downcase
    when "yes","y"
      @current_user.aliens << Alien.find_or_create_by(name: current_alien.name, status: current_alien.status, species: current_alien.species, planet_id: current_alien.planet_id, points: current_alien.name.length)
      puts "#{current_alien.name}: Awesome, see you soon!"
      break
    when "no","n"
      puts "#{current_alien.name}: Fine! Whatever!"
      break
    else
      puts "YES or NO! It's not that hard!"
    end
  end
end

# MAIN MENU INPUT
portal_gun_charge = 0
while portal_gun_charge < 10
  while user_input = gets.chomp
    case user_input
    when "2" 
        @random_planet = Planet.all.sample
        @alien = Alien.all.where("planet_id = ?", @random_planet.id)
        portal_gun_charge += 1
        system('clear')
        open_portal(portal_gun_charge)
        # puts "Portal gun charges left: #{portal_gun_charge} / 10"
        # puts "\033[1;32m\ A portal opens up!"
        # puts "\033[1;37m\ You step through & find yourselves on\033[1;36m\
        print " #{@random_planet.name}\033[0m\ "
        puts @alien.size < 1 ? create_alien : collect_alien
        puts ""
        puts main_menu if portal_gun_charge < 10
      when "1"
        portal_gun_charge += 1
        puts "Portal gun charges left: #{portal_gun_charge} / 10"
        system('clear')
        @current_user.visit_planet
        puts main_menu if portal_gun_charge < 10
      when "3"
        system('clear')
        puts @current_user.main_mortydex
        puts ""
        puts main_menu
      when "5"
        system('clear')
        puts "Rick is disappointed."
        sleep(1)
        end_game
        break
      when "4"
        system('clear')
        puts "Your current score is: #{@current_user.current_score}"
        puts ""
        puts main_menu
    end
    break
  end
end

portal_gun_drained
