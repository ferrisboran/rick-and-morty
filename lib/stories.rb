  ########## TRAVELING TO PLANETS ############

def open_portal
  system('clear')
  puts ""
  puts "Portal gun charges left: #{@portal_gun_charge} / 10"
  puts ""
  puts "\033[1;32m\ A portal opens up!"
  sleep(1)
  print "\033[1;37m\ You step through & find yourselves on\033[1;36m\ "
end

  @random_welcome = ["Ga-ga blahg blahg?", "You got any Flurbos? Come on bro, I need to play 'Roy 2'!", "Did you just come through a portal? Your ferrari must be in the shop.", "You can run but you can't hide, Bitch!","Welcome, I am here if you need to talk.", "Don't touch anything. This whole planet eats their own poop.", "Everything is a lie! The points don't matter!"]

  @random_save_reply = ["WTF! THAT THING IS SUCKING ME IN!", "Excuse me! I did NOT give consent for that!", "Ok, but I get to use a picture of you later *wink wink*", "Ok, but only if you twist these dangly parts first!", "Ga-ga blahg blahg ahga blahg ga!!"]

  def display_five_planets
    five_planets = []
    i = 0
    Planet.display_all_planets.sample(5).map do |planet|
      plnt = "#{i+1}. #{planet}"
      five_planets << planet
      puts plnt
      i += 1
    end
    puts "Choose a Planet:"
    input = gets.chomp
    planet_input = input.to_i
    Planet.find_by(name: five_planets[planet_input-1])
  end

  def review_planet_profile(planet_input)
    # @selected_planet = planet_input
    @alien = planet_input.aliens.to_a.map { |resident| resident.name }
    system('clear')
    puts <<-PLANET_PROFILE

    Planet: #{planet_input.name}
    ------------------------------
    Aliens Present: #{@alien.sample(5).uniq.join(", ")}

    PLANET_PROFILE
    puts ""
    puts "Would you like to go here? yes/no"
    planet_back_input = gets.chomp
    case planet_back_input.downcase
      when "yes", 'y'
        open_portal
        print "#{planet_input.name}\033[0m\ "
      when "no", "n"
        Planet.display_five_planets
    end
    planet_input.aliens
  end

  ########## END GAME SEQUENCE ###############
  def end_game
    system('clear')
    sleep(1)
    puts "Your final score is: #{@current_user.current_score}"
    sleep(1)
    puts "--- Your final Mortydex ---"
    puts @current_user.mortydex
    sleep(1)

    puts "Play again?"
    while play_again = gets.chomp
      case play_again
      when "yes","y"
        Mortydex.destroy_all
        mainmenu
      when "no","n"
        Mortydex.destroy_all
        puts "Ok bye!"
        # titlemenu - coming soon
      end
    end
  end

  def portal_gun_drained
    puts "Portal gun drained!"
    end_game
  end

  ########## NEW USER STORY ##################
  @morty = "\033[1;33m\ Morty: \033[1;36m\ "
  @beth = "\033[1;31m\ Beth: \033[1;34m\ "
  @jerry = "\033[0;32m\ Jerry: \033[1;30m\ "
  @summer = "\033[1;35m\ Summer: \033[1;37m\ "
  @rick = "\033[1;36m\ Rick: \033[0;33m\ "

  @story_line = [
    "     .",
    "    ...  ",
    "   .....  ",
    "  .......  ",
    "   ",
    "#{@morty}Hey Rick?",
    "#{@morty}I need help with this",
    "  school project.",
    "  Rick...",
    "  Rick!",
    "  RICK!!",
    "   ",
    "#{@rick}No, Morty! I'm busy!",
    "   ",
    "#{@beth}Hey, Dad?",
    "#{@beth}Tommy escaped Froopy Land",
    "  and ate 3 kids down the block.",
    "#{@beth}I need you to clone",
    "  new ones before anyone notices",
    "   ",
    "#{@rick}I've showed you how.",
    "  You do it!",
    "   ",
    "#{@jerry}Rick?",
    "  #{@erry}I told you Morty needs",
    "  to go to school!",
    "#{@jerry}But I'm the victim here",
    "  because you're ruining my life!",
    "   ",
    "#{@rick}I don't have time for your",
    "  insecurities, Jerry.",
    "   ",
    "#{@summer}Grandpa Rick?",
    "#{@summer}How come you never take me",
    "  on an adventure?",
    "#{@summer}It's because I'm a girl,",
    "  isn't it?!",
    "   ",
    "#{@rick}...",
    "  That's it!",
    "  You guys are driving me nuts!",
    "#{@rick}I'm going on vacation!",
    "  Morty, take your friend with you",
    "  And gather the information I need",
    "  For my research.",
    "  \033[1;30m\ ",
    "    [Rick starts building something]",
    "    ",
    "    ",
    "#{@rick}Here, take this.",
    "   \033[0m\ ",
    "           .--.",
    "       .-========-.",
    "       | === [__] |",
    "       | [__][__] |",
    "       | o   ==== |",
    "       | LILILILI |",
    "       | LILILILI |",
    "       | LILILILI |",
    "       | LILILILI |",
    "       |  __  __  |",
    "       | [__][__] |",
    "       | [__][][] |",
    "       | [__] ==  |",
    "   jgs |      OOO |",
    "       '-========-'",
    "   ",
    "#{@rick}",
    "  I call it a Mortydex.",
    "  It's similar to that game you",
    "  keep raving about.",
    "   ",
    "#{@morty}You mean 'Pokemon'?",
    "   ",
    "#{@rick}Whatever, Morty. I don't care.",
    "  Just try to gather as much",
    "  information before",
    "  the portal gun runs out of charge.",
    "#{@rick}This is very important",
    "  for my research",
    "  so don't mess it up!",
    "#{@rick}Oh, and try to not",
    "  to kill your friend here\033[0m\ ",
    "  .......",
    "   .....",
    "    ...",
    "     .",
    "   "
  ]

  ########## RETURNING USER WELCOME ###########
  def returning_user_story(username)
    system('clear')
    puts "#{@rick}Get out of here, Morty! And take #{username} with you...\033[1;30m\ "
  end
