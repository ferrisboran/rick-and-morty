
require 'pry'

  ########## TRAVELING TO PLANETS ############
@planet_graphic =
"  \033[1;37m
  ~+

          *       +
    '                  |
()    .-.,=\"\`\`\"=.    - o -
      '=/_       \\     |
   *   |  '=._    |
        \\     `=./`,        '
     .   '=.__.=' `='      *
+                         +
 O      *        '       .


 "
@select_planet_graphic = "\033[1;37m
.             *        .     .       .
     .     _     .     .            .       .
.    . _  / |      .        .  *         _  .     .
      | \\_| |                           | | __
    _ |     |                   _       | |/  |
   | \\      |      ____        | |     /  |    \\
   |  |     \\    +/_\\/_\\+      | |    /   |     \\
__/____\\--...\\___ \\_||_/ ___...|__\\-..|____\\____/__
    .     .      |_|__|_|         .       .
 .    . .       _/ /__\\ \\_ .          .
    .       .    .           .         .
"
@visit_planet_graphic = "\033[1;32m
                    .-.
     .-\"\"`\"\"-.    |(@ @)
  _/`oOoOoOoOo`\\_ \\ \\-/
 '.-=-=-=-=-=-=-.' \\/ \\
   `-=.=-.-=.=-'    \\ /\\
      ^  ^  ^       _H_ \\"

def open_portal
  system('clear')
  puts @visit_planet_graphic
  puts ""
  puts "Portal gun charges left: #{@portal_gun_charge} / 10"
  puts ""
  puts "\033[1;32m\ A portal opens up!"
  sleep(1)
  print "\033[1;37m\ You step through & find yourselves on\033[1;36m\ "
end

  @random_welcome = ["Ga-ga blahg blahg?", "You got any Flurbos? Come on bro, I need to play 'Roy 2'!", "Did you just come through a portal? Your ferrari must be in the shop.", "You can run but you can't hide, Bitch!","Welcome, I am here if you need to talk.", "Don't touch anything. This whole planet eats their own poop.", "Everything is a lie! The points don't matter!"]

  @random_smooth_save = ["WTF! THAT THING IS SUCKING ME IN!", "Ok, but I get to use a picture of you later *wink wink*", "Ok, but only if you twist these dangly parts first!", "Oh yea, baby! Come over here!"]

  @random_not_smooth = ["Excuse me! I did NOT give consent for that!", "Ga-ga blahg blahg ahga blahg ga!!","Think for yourself. Don't be sheep.","Yea, well, same to you pal! I'm outta here!", "You're lucky a Traflorkian doesn't hear you say that"]

  def display_five_planets
    puts @planet_graphic

    five_planets = []
    i = 0
    Planet.display_all_planets.sample(5).map do |planet|
      plnt = "#{i+1}. #{planet}"
      five_planets << planet
      puts plnt
      i += 1
    end

    puts " \033[0m "
    select_planet_menu = ["Choose one of these planets?", "Go back to Menu"]
    while select_planet_menu_input = @prompt.select("There are literally a bijillion worlds! I don't feel like doing all there work. Pick from these 5 instead.", select_planet_menu)
      case select_planet_menu_input
      when "Choose one of these planets?"
        planet_input = @prompt.ask("Which numbered planet? ") do |num|
          num.validate ->(num) { (1..5).to_a.include?(num.to_i) }
          num.messages[:valid?] = "That's not a choice! Do I have to hold your hand? "
        end
        break
      when "Go back to Menu"
        system('clear')
        mainmenu
        break
      end
      break
    end
    Planet.find_by(name: five_planets[planet_input.to_i-1])
  end

  def review_planet_profile(planet_input)
    @alien = planet_input.aliens.to_a.map { |resident| resident.name }
    system('clear')
    puts @select_planet_graphic
    puts <<-PLANET_PROFILE

    Planet: #{planet_input.name}
    \033[0;32m------------------------------
    Aliens Present: #{@alien.sample(5).uniq.join(", ")}
    \033[0m
    PLANET_PROFILE
    puts ""
    while visit_planet_input = @prompt.select("Would you like to go here?", ["Yes","No"])
      case visit_planet_input
      when "Yes"
        open_portal
        print "#{planet_input.name}\033[0m\ "
        break
      when "No"
        collect_alien(review_planet_profile(display_five_planets))
      end
    end
    planet_input.aliens
  end

  def save_alien(alien)
    current_alien = @current_alien
    @current_user.aliens << Alien.find_or_create_by(name: current_alien.name, status: current_alien.status, species: current_alien.species, planet_id: current_alien.planet_id, points: current_alien.name.length)
  end

  def collect_alien(alien)
    @current_alien = alien.sample
    alien_response = "\033[0;35m\ #{@current_alien.name}:\033[0;36m\ "
    puts ""
    puts "You bump into\033[0;35m\ #{@current_alien.name}"
    puts "#{alien_response}#{@random_welcome.sample}"
    puts "\033[0m\ "
    puts "How smooth are you? Win them over to add their info to your Mortydex!"
    sleep(1)
    puts "Repeat the phrase below as fast as you can!"
    puts "Ready?"
    sleep(1)
    puts "GO!!"
    rand_phrase = ["Squanch", "Mega Fruit", "Snuffles", "Meeseeks", "Evil Morty", "Rikitikitavi, bitch!", "It's getting weird!"]
    rsample = rand_phrase.sample
    puts "\033[1;37m"
    rand_phrase = @prompt.ask("#{rsample} >> ") do |phrase|
      phrase.validate ->(p) { rsample.downcase == p.downcase }
      phrase.messages[:valid?] = "You can't split time! Try again! "
    end
    puts "\033[0m"
    rand_num = rand(1..10)
    puts "They give you a weird look..."
    sleep(1)
    if @random_smooth_save.sample == "WTF! THAT THING IS SUCKING ME IN!"
      puts "#{alien_response}WTF! THAT THING IS SUCKING ME IN!"
      sleep(2)
      puts "\033[0m\ "
      system('clear')
      puts "Uh oh! You didn't win them over but your Mortydex sucked them in!"
      sleep(0.2)
      save_alien(@current_alien)
      puts "Their info has been saved."
      sleep(1)
    elsif rand_num.even?
      puts "#{alien_response}#{@random_smooth_save.sample}"
      sleep(2)
      puts "\033[0m\ "
      save_alien(@current_alien)
      system('clear')
      puts "Congrats! You won them over! Their info has been saved."
      sleep(1)
    else
      puts "#{alien_response}#{@random_not_smooth.sample}"
      sleep(2)
      puts "\033[0m\ "
      system('clear')
      puts "Wow... That was terrible. You've been kicked off the Planet."
      @current_user.aliens << Alien.find_or_create_by(name: "Unknown", status: "Unknown", species: "Unknown", planet_id: @current_alien.planet_id, points: 0)
      sleep(1)
    end
  end
