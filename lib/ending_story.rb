require "pry"
########## END GAME SEQUENCE ###############
def stats_play_again
  sleep(1)
  puts "--- Your final Mortydex ---"
  puts @current_user.mortydex
  sleep(1)
  end_game_credits
  # puts "Play again? (y/n)"
  # while play_again = gets.chomp
  #   case play_again
  #   when "yes","y"
  #     # Mortydex.destroy_all # KEEP HIGH SCORE IN HIGH SCORE TABLE
  #     @current_user.reset_mortydex
  #     @portal_gun_charge = 0
  #     returning_user_story(@current_user.name)
  #     mainmenu
  #     break
  #   when "no","n"
  #     puts "Ok bye!"
  #     # title_menu
  #     exit!
  #     # break
  #   end
  # end
end

def quit_game_early
  system('clear')
  sleep(1)
  fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/disqual.wav" }
  stats_play_again
end

def portal_gun_drained
  puts "Portal gun drained!"
  fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/I_like_what_you_got.wav" }
  stats_play_again
end

def end_game_credits
  puts ""
  while end_game_input = @prompt.select("Play Again?",["Yes", "No"])
    # binding.pry
    case end_game_input
    when "Yes"
      @current_user.reset_mortydex
      @portal_gun_charge = 0
      returning_user_story(@current_user.name)
      mainmenu
      break
    when "No"
      system('clear')
      fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/endgame_scream.mp3" }
      sleep(0.5)
      puts "CREDITS".center(75)
      puts "In Alphabetical Order".center(75)
      sleep(0.5)
      puts ""
      sleep(0.5)
      puts "Chief Meeseeks Officer".center(75)
      sleep(0.5)
      puts "David Zhang".center(75)
      sleep(0.5)
      puts ""
      puts "Chief Squanch Officer".center(75)
      sleep(0.5)
      puts "Edgar Ong".center(75)
      sleep(0.5)
      puts ""
      puts "Chief Awesome Officer".center(75)
      sleep(0.5)
      puts "Ferris Boran".center(75)
      3.times do
        sleep(0.5)
        puts ""
      end
      puts @title_ascii
      fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/oowee.wav"}
      sleep(7)
      exit!
    end
  end
end
