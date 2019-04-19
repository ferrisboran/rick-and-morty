require "pry"
@added_aliens = []
def load_aliens_and_planets(username)
  fork{ exec 'afplay', "/Users/ferrisboran/git-todo/projects/rick-and-morty/sound/Rick-and-Morty-Theme-Song.mp3" }
  binding.pry
  i = 1
  if !User.find_by(name: username)
    while i < 100
      @added_aliens << (JSON.parse(RestClient.get("https://rickandmortyapi.com/api/character/#{i}").body))
      puts @story_line[i-1]
      i += 1
    end
    @added_aliens.each do |alien|
      if !!alien["origin"]["name"]
        planets = Planet.find_or_create_by(name: alien["origin"]["name"])
        Alien.find_or_create_by(name: alien["name"], status: alien["status"], species: alien["species"], planet_id: planets.id, points: alien["name"].length)
      end
    end
  else
    returning_user_story(@username)
  end
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
  "   \033[0;35m\ ",
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
