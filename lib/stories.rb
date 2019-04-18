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
    while planet_back_input = gets.chomp
      case planet_back_input.downcase
        when "yes", 'y'
          open_portal
          print "#{planet_input.name}\033[0m\ "
          break
        when "no", "n"
          display_five_planets
          break # AFTER PRESSING NO ONCE, NEXT 5 PLANETS, SELECT ONE TAKES YOU DIRECTLY TO PLANET SELECTED
        else
          puts "YES or NO! It's not that hard!"
      end
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
        Mortydex.destroy_all # KEEP HIGH SCORE IN HIGH SCORE TABLE
        mainmenu
        break
      when "no","n"
        puts "Ok bye!"
        exit! # CHANGE TO TITLE Menu
        # break
      end
    end
  end

  def portal_gun_drained
    puts "Portal gun drained!"
    end_game
  end
