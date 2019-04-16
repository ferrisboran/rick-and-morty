########## NEW USER STORY ##################
@morty = "\033[1;33m\ Morty: \033[1;36m\ "
@beth = "\033[1;31m\ Beth: \033[1;34m\ "
@jerry = "\033[0;32m\ Jerry: \033[1;30m\ "
@summer = "\033[1;35m\ Summer: \033[1;37m\ "
@rick = "\033[1;36m\ Rick: \033[0;33m\ "

def new_user_story(username)
  puts "#{@morty}Hey Rick?"
  puts "#{@beth}Hey, Dad?"
  puts "#{@jerry}Rick?"
  puts "#{@summer}Grandpa Rick?"
  puts "#{@rick}I'm going on vacation!"
end


new_user_story("ferryrules")



########## RETURNING USER WELCOME ###########
def returning_user_story(username)
  puts "#{@rick}Get out of here, Morty! And take #{username} with you..."
end

returning_user_story("ferryrules")
