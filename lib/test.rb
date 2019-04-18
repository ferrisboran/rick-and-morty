# require_relative '../config/environment'
# require 'rest-client'
# require 'json'
# require 'pry'
# require 'rickmorty'
# require "tty"
# prompt = TTY::Prompt.new
#
# @test_current_user = prompt.ask('Username: ')
#
# @test_main_menu = ["Select a Planet", "Go to a Random Planet", "View Mortydex", "View High Score", "Go Home (Quit)"]
#
#
# @test_portal_gun_charge = 0
#
# while @test_portal_gun_charge < 10
#   while main_menu_input = prompt.select("Choose Your Next Move", @test_main_menu)
#     case main_menu_input
#     when "Select a Planet"
#       test_select_planet
#     when "Go to a Random Planet"
#       puts "I got to a random planet"
#     when "View Mortydex"
#       puts "I view mortydex"
#     when "View High Score"
#       puts "I view high score"
#     when "Go Home (Quit)"
#       puts "I quit!"
#     end
#   end
# end
#
# # while @portal_gun_charge < 10
# #   while @input # user_input = gets.chomp
# #     case @input # user_input
# #       when "1"
# #         @portal_gun_charge += 1
# #         system('clear')
# #         puts ""
# #         collect_alien(review_planet_profile(display_five_planets))
# #         puts ""
# #         mainmenu
# #       when "2"
# #         @portal_gun_charge += 1
# #         @random_planet = Planet.all.sample
# #         system('clear')
# #         open_portal
# #         print " #{@random_planet.name}\033[0m\ "
# #         puts ""
# #         collect_alien(@random_planet.aliens)
# #         puts ""
# #         puts ""
# #         mainmenu
# #       when "3"
# #         system('clear')
# #         puts @current_user.main_mortydex
# #         puts ""
# #         mainmenu
# #       when "5"
# #         system('clear')
# #         puts "Rick is disappointed."
# #         sleep(1)
# #         end_game
# #         break
# #       when "4"
# #         system('clear')
# #         # puts "Your current score is: #{@current_user.current_score}"
# #         puts @current_user.highscore
# #         puts ""
# #         mainmenu
# #       # else
# #     end
# #     break
# #   end
# # end
# #
# # portal_gun_drained
