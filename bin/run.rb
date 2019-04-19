require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rickmorty'
require "tty"
@prompt = TTY::Prompt.new

# INTRO & LOGIN title methiod
system('clear')
puts @title_ascii # variable inside title_page.rb
sleep(3)
title_menu = ["New Game".center(75), "Quit".center(73)]

while title_menu_input = @prompt.select("Let's get this S%!t going!".center(77),title_menu)
  case title_menu_input
  when "New Game".center(75)
    system('clear')
    puts @user_create_or_login # variable inside title_page.rb
    sleep(0.5)
    fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/Show_me.wav" }
    @username = @prompt.ask("Username: ")
    load_aliens_and_planets(@username) # method inside opening_story.rb
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
    puts main_menu_graphic # method inside opening_story.rb
    while main_menu_input = @prompt.select("Let's go on another adventure Ric.. I mean #{@current_user.name}!", main_menu)
      case main_menu_input
      when "Select a Planet"
        @portal_gun_charge += 1
        system('clear')
        puts ""
        collect_alien(review_planet_profile(display_five_planets)) # methods inside game_play_story.rb
        puts ""
      when "Go to a Random Planet"
        @portal_gun_charge += 1
        @random_planet = Planet.all.sample
        system('clear')
        open_portal # method inside stories.rb
        print " #{@random_planet.name}\033[0m\ "
        puts ""
        collect_alien(@random_planet.aliens) #method inside game_play_story.rb
        puts ""
      when "View Mortydex"
        system('clear')
        puts @current_user.main_mortydex # method inside User class
        puts ""
      when "View High Score"
        system('clear')
        puts @current_user.highscore
        puts ""
      when "*sobbing* I just want to go home!"
        quit_game_early # method inside ending_story.rb
        break
      end
      break
    end
  end
  portal_gun_drained # method inside ending_story.rb
end

mainmenu
