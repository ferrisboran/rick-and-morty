
  ########## NEW USER STORY ##################
  @morty = "\033[1;33m\ Morty: \033[1;36m\ "
  @beth = "\033[1;31m\ Beth: \033[1;34m\ "
  @jerry = "\033[0;32m\ Jerry: \033[1;30m\ "
  @summer = "\033[1;35m\ Summer: \033[1;37m\ "
  @rick = "\033[1;36m\ Rick: \033[0;33m\ "

  @story_line = [
    "#{@morty}Hey Rick?",
    "#{@morty}I need help with this",
    "  school project.",
    "  Rick...",
    "  Rick!",
    "  RICK!!",
    "#{@beth}Hey, Dad?",
    "#{@beth}Tommy escaped Froopy Land",
    "  and ate 3 kids down the block.",
    "#{@beth}I need you to clone",
    "  new ones before anyone notices",
    "#{@jerry}Rick?",
    "  #{@erry}I told you Morty needs",
    "  to go to school!",
    "#{@jerry}But I'm the victim here",
    "  because you're ruining my life!",
    "#{@summer}Grandpa Rick?",
    "#{@summer}How come you never take me",
    "  on an adventure?",
    "#{@summer}It's because I'm a girl,",
    "  isn't it?!",
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
    "  to kill your friend here\033[0m\ "
  ]

  def new_user_story(username)

  end

  # new_user_story("ferryrules")

  ########## RETURNING USER WELCOME ###########
  def returning_user_story(username)
    system('clear')
    puts "#{@rick}Get out of here, Morty! And take #{username} with you...\033[1;30m\ "
  end

  # returning_user_story("ferryrules")

  ########## COLORS ##############
