require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'

# INTRO & LOGIN title methiod
  puts "ADD A TITLE PAGE!!!"
  def title_menu
    puts <<-TITLE
    1. Start A New Game
    2. Continue Playing
    3. Exit

    Select [1, 2, 3]:
    TITLE
    @input = gets.chomp
  end

  title_menu

# INTRO & LOGIN

  #  NEW USER - CHECK TO MAKE SURE USER NAME NOT TAKEN
  aliens = []
  while @input
    case @input
      when "1", 1
        system('clear')
        puts "Create player"
        print "Username: "

        @username = gets.chomp

        i = 1
        if !User.find_by(name: @username)
          puts "Please wait"
          while i < 100
            aliens << (JSON.parse(RestClient.get("https://rickandmortyapi.com/api/character/#{i}").body))
            puts @story_line[i-1]
            i += 1
          end
        end
        break
    # 2. LOGIN - CHECK TO MAKE SURE THE USER NAME EXISTS
      when "2", 2
        system('clear')
        puts "Welcome back!! whoever the hell you are"
        puts "Nice to see you again: "
        print "Username: "
        username = gets.chomp.to_s
        @current_user = User.find_by(name: username)
        returning_user_story(username)
        break
      when "3", 3
        puts "ok adios"
        exit!
      else
        title_menu
    end
  end


  # finds or create users then creates a new mortydex for the current user
  @current_user = User.find_or_create_by(name: username)
  Mortydex.find_or_create_by(user_id: @current_user.id)

  @current_user.reset_mortydex

# PLANETS CREATED FROM ALIEN
aliens.each do |alien|
  if !!alien["origin"]["name"]
    planets = Planet.find_or_create_by(name:alien["origin"]["name"])
    Alien.find_or_create_by(name: alien["name"], status: alien["status"], species: alien["species"], planet_id: planets.id, points: alien["name"].length)
  end
end

# MAIN MENU
@portal_gun_charge = 0
def mainmenu
  puts "Choose Your Next Move:
        1. Select a Planet
        2. Go to a Random Planet
        3. View Mortydex
        4. View High Score
        5. Go Home(Quit)"
  @input = gets.chomp
  @input
end

mainmenu

# INSTANCE METHODS
def save_alien(alien)
  current_alien = @current_alien
  @current_user.aliens << Alien.find_or_create_by(name: current_alien.name, status: current_alien.status, species: current_alien.species, planet_id: current_alien.planet_id, points: current_alien.name.length)
end

def collect_alien(alien)
  @current_alien = alien.sample #if !@current_user.aliens
  alien_response = "\033[0;35m\ #{@current_alien.name}:\033[0;36m\ "
  puts ""
  puts "You bump into\033[0;35m\ #{@current_alien.name}"
  puts "#{alien_response}#{@random_welcome.sample}"
  puts "\033[0m\ "
  puts "How smooth are you? Win them over to add their info to your Mortydex!"
  smooth_talker = gets.chomp
  rand_num = rand(1..10)
  puts "They give you a weird look..."
  sleep(1)
  if @random_smooth_save.sample == "WTF! THAT THING IS SUCKING ME IN!"
    puts "#{alien_response}WTF! THAT THING IS SUCKING ME IN!"
    sleep(1)
    puts "\033[0m\ "
    puts "Uh oh! You didn't win them over but your Mortydex sucked them in!"
    sleep(0.2)
    save_alien(@current_alien)
    puts "Their info has been saved."
  elsif rand_num.even?
    puts "#{alien_response}#{@random_smooth_save.sample}"
    sleep(1)
    puts "\033[0m\ "
    save_alien(@current_alien)
    puts "Congrats! You won them over! Their info has been saved."
  else
    puts "#{alien_response}#{@random_not_smooth.sample}"
    sleep(1)
    puts "\033[0m\ "
    puts "Wow... That was terrible. You've been kicked off the Planet."
    @current_user.aliens << Alien.create(name: "Unknown", status: "Unknown", species: "Unknown", planet_id: @current_alien.planet_id, points: 0)
  end
end

# MAIN MENU INPUT
# @portal_gun_charge = 0
while @portal_gun_charge < 10
  while @input # user_input = gets.chomp
    case @input # user_input
      when "1"
        @portal_gun_charge += 1
        system('clear')
        puts ""
        collect_alien(review_planet_profile(display_five_planets))
        puts ""
        mainmenu
      when "2"
        @portal_gun_charge += 1
        @random_planet = Planet.all.sample
        system('clear')
        open_portal
        print " #{@random_planet.name}\033[0m\ "
        puts ""
        collect_alien(@random_planet.aliens)
        puts ""
        puts ""
        mainmenu
      when "3"
        system('clear')
        puts @current_user.main_mortydex
        puts ""
        mainmenu
      when "5"
        system('clear')
        puts "Rick is disappointed."
        sleep(1)
        end_game
        break
      when "4"
        system('clear')
        # puts "Your current score is: #{@current_user.current_score}"
        puts @current_user.highscore
        puts ""
        mainmenu
      # else
    end
    break
  end
end

portal_gun_drained
# method from stories.rb
