require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'
require "tty"
@prompt = TTY::Prompt.new

# INTRO & LOGIN title methiod
system('clear')
puts @title_ascii
sleep(5)
title_menu = ["New Game".center(75), "Quit".center(73)]

while title_menu_input = @prompt.select("Let's get this S%!t going!".center(77),title_menu)
  case title_menu_input
  when "New Game".center(75)
    system('clear')
    puts @user_create_or_login
    sleep(0.5)
    fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/Show_me.wav" }
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
        quit_game_early
        break
      end
      break
    end
  end
  portal_gun_drained
end

mainmenu
