########## END GAME SEQUENCE ###############
def stats_play_again
  sleep(1)
  puts "--- Your final Mortydex ---"
  puts @current_user.mortydex
  sleep(1)
  puts "Play again?"
  while play_again = gets.chomp
    case play_again
    when "yes","y"
      # Mortydex.destroy_all # KEEP HIGH SCORE IN HIGH SCORE TABLE
      @current_user.reset_mortydex
      @portal_gun_charge = 0
      returning_user_story(@current_user.name)
      mainmenu
      break
    when "no","n"
      puts "Ok bye!"
      # title_menu
      exit!
      # break
    end
  end
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
  out_of_turns
end
