
require "pry"
# def valid_input
#   puts "type yes/no"        #requiring a user input
#   input = gets.chomp        #gets user input
#   until input == "yes" || input == "no"
#   print "Please enter a valid input: "
#   input = gets.chomp
#   end
# end
#
# valid_input


# def valid_input_for_interger
#   puts "type in a valid interger between 1 to 5:"
#   inputs = gets.chomp.to_i
#   while input.include?("1", "2", "3", "4", "5")
#     puts "Please enter a valid input: "
#     input = gets.chomp.to_i
#   end
#   binding.pry
# end
#
# valid_input_for_interger
#
#

def verify
  input = gets.chomp.to_i
  begin
    input.to_i > 0 || input.to_i < 5
  rescue
    input.to_i < 0 || input.to_i >5
 puts "good job"
end

verify













#   def title_menu
#     puts "Hello gamer this is the welcome message:
#     1. New to Mortty game
#     2. I'M back!
#     3. View High Score
#     4. Gota Go~"
#     puts "select your option:"
#     @login = gets.chomp.to_s
#     @login
#     end
#
# # INTRO & LOGIN
#
#   # 1. NEW USER - CHECK TO MAKE SURE USER NAME NOT TAKEN
#   while @login #title menu login input
#     case @login
#     when "1"
#       system('clear')
#       puts "Welcome to Rick and Morty exciting adventure! Please enter your name:"
#       username = gets.chomp.to_s
#       if !User.find_by(name: username)
#         @current_user = User.create(name: username)
#       else
#         puts "Username has taken"
#       end
#       mainmenu
#   # 2. LOGIN - CHECK TO MAKE SURE THE USER NAME EXISTS
#     when "2"
#       system('clear')
#       Puts "Welcome back!! whoever the hell you are"
#       puts "Nice to see you again: "
#       username = gets.chomp.to_s
#       @current_user = User.find_by(name: username)
#
#       mainmenu
#   # 3. VIEW HIGH SCORES - BLOCKER @edgar
#     when "3"
#       puts "working on it"
#       mainmenu
#
#     # 4. QUIT - exit!
#     when "4"
#       puts "ok adios"
#         exit!
#       end
#     end
#
