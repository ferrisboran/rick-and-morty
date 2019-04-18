require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'
require "tty"
@prompt = TTY::Prompt.new

# INTRO & LOGIN title methiod
puts @title_ascii

title_menu = ["New Game".center(75), "Quit".center(73)]

while title_menu_input = @prompt.select("Let's get this S%!t going!".center(77),title_menu)
  case title_menu_input
  when "New Game".center(75)
    system('clear')
    puts @user_create_or_login
    puts "SHOW ME WHAT YOU GOT!"
    @username = @prompt.ask("Username: ")
    load_aliens_and_planets(@username)
    break
  when "Quit".center(73)
    exit!
  end

end

@current_user = User.find_or_create_by(name: @username)
Mortydex.find_or_create_by(user_id: @current_user.id)

@current_user.reset_mortydex

# MAIN MENU
@portal_gun_charge = 0
def mainmenu
  main_menu = ["Select a Planet", "Go to a Random Planet", "View Mortydex", "View High Score", "*sobbing* I just want to go home!"]
  while @portal_gun_charge < 10
    while main_menu_input = @prompt.select("OMG JUST CHOOSE SOMETHING ALREADY!", main_menu)
      case main_menu_input
      when "Select a Planet"
        @portal_gun_charge += 1
        system('clear')
        puts ""
        collect_alien(review_planet_profile(display_five_planets))
        puts ""
      when "Go to a Random Planet"
        @portal_gun_charge += 1
        @random_planet = Planet.all.sample
        system('clear')
        open_portal
        print " #{@random_planet.name}\033[0m\ "
        puts ""
        collect_alien(@random_planet.aliens)
        puts ""
      when "View Mortydex"
        system('clear')
        puts @current_user.main_mortydex
        puts ""
      when "View High Score"
        system('clear')
        puts @current_user.highscore
        puts ""
      when "*sobbing* I just want to go home!"
        end_game
        break
      end
    end
  end
end

mainmenu

# INSTANCE METHODS
# def save_alien(alien)
#   current_alien = @current_alien
#   @current_user.aliens << Alien.find_or_create_by(name: current_alien.name, status: current_alien.status, species: current_alien.species, planet_id: current_alien.planet_id, points: current_alien.name.length)
# end
#
# def collect_alien(alien)
#   @current_alien = alien.sample #if !@current_user.aliens
#   alien_response = "\033[0;35m\ #{@current_alien.name}:\033[0;36m\ "
#   puts ""
#   puts "You bump into\033[0;35m\ #{@current_alien.name}"
#   puts "#{alien_response}#{@random_welcome.sample}"
#   puts "\033[0m\ "
#   puts "How smooth are you? Win them over to add their info to your Mortydex!"
#   smooth_talker = gets.chomp
#   rand_num = rand(1..10)
#   puts "They give you a weird look..."
#   sleep(1)
#   if @random_smooth_save.sample == "WTF! THAT THING IS SUCKING ME IN!"
#     puts "#{alien_response}WTF! THAT THING IS SUCKING ME IN!"
#     sleep(1)
#     puts "\033[0m\ "
#     puts "Uh oh! You didn't win them over but your Mortydex sucked them in!"
#     sleep(0.2)
#     save_alien(@current_alien)
#     puts "Their info has been saved."
#   elsif rand_num.even?
#     puts "#{alien_response}#{@random_smooth_save.sample}"
#     sleep(1)
#     puts "\033[0m\ "
#     save_alien(@current_alien)
#     puts "Congrats! You won them over! Their info has been saved."
#   else
#     puts "#{alien_response}#{@random_not_smooth.sample}"
#     sleep(1)
#     puts "\033[0m\ "
#     puts "Wow... That was terrible. You've been kicked off the Planet."
#     @current_user.aliens << Alien.create(name: "Unknown", status: "Unknown", species: "Unknown", planet_id: @current_alien.planet_id, points: 0)
#   end
# end

# MAIN MENU INPUT
# @portal_gun_charge = 0
# while @portal_gun_charge < 10
#   while @input # user_input = gets.chomp
#     case @input # user_input
#       when "1",1
#         @portal_gun_charge += 1
#         system('clear')
#         puts ""
#         collect_alien(review_planet_profile(display_five_planets))
#         puts ""
#         mainmenu
#       when "2",2
#         @portal_gun_charge += 1
#         @random_planet = Planet.all.sample
#         system('clear')
#         open_portal
#         print " #{@random_planet.name}\033[0m\ "
#         puts ""
#         collect_alien(@random_planet.aliens)
#         puts ""
#         puts ""
#         mainmenu
#       when "3",3
#         system('clear')
#         puts @current_user.main_mortydex
#         puts ""
#         mainmenu
#       when "5",5
#         system('clear')
#         puts "Rick is disappointed."
#         sleep(1)
#         end_game
#         break
#       when "4",4
#         system('clear')
#         # puts "Your current score is: #{@current_user.current_score}"
#         puts @current_user.highscore
#         puts ""
#         mainmenu
#       else
#         mainmenu
#     end
#     break
#   end
# end

portal_gun_drained
# method from stories.rb
