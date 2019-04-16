Rick wants "me-time" and send you on an adventure with Morty
Rick builds you a Morty-dex & tells you & Morty to collect a bunch of different aliens

# CRUD

C - For planets with no residents, an "unknown" alien appears and you can create them
      Alien.new(name, status [dead/alive], species) - will add to aliens table and associate current planet id, current user id, points = name.length

R - Look at previous Planets gone to & list of collected Aliens
      Search your database by alien name/id and planet name/id [bonus: see how many residents you have not captured yet]

U - Return to a previous planet & update info

D - Remove planets or aliens because they're horrible

# TABLES

User - has many planets, has many aliens through morty-dex
id | name

Planets - has many aliens
id | name

Aliens - belongs to planet, belongs to user through morty-dex
id | name | status | species | planet_id | points
1                               10

Morty-dex - has many aliens, has many planets, belongs to user
id | user_id |  alien_id
1     1         1
2     1         2
3     1         3


# USER STORIES
As a user...
- I want to be able to enter my name to retrieve my records or create new user
- Be given a purpose/backstory about what we're doing (Simple dialog about what Rick wants you to do [bonus: add ascii art/audio clip])
- Search for a planet by name
 -- Returns a list of planets that match or closely match search term
- Given a list of planets (5 planets per page) to explore: (Select planet by choosing the number aligned with planet)
 -- Select a new planet
  --- List of planets not yet explored
 -- Go back to a planet (Option only populates if a user has been to a planet)
  --- List of planets previously visited (Excludes current planet)
  --- search by alien name you have met then visit that planets(?)
 -- I don't want to go to these planets, I want to see other planets
  --- Sees the next list of planets
 -- I just want to go home
  --- Game ends
  --- Rick ridicules you for leaving early & for having low score (i.e. < 100)-or- [bonus: add ascii art/audio clip]
  --- Still ridicules you and calls you an overachiever if you have a high score (i.e. > 100) [bonus: add ascii art/audio clip]
- Save aliens & planets for future retrieval
 -- Cannot interact with more than 5 aliens at a time on a single planet (Portal gun jumps you to random new planet)

As a returning user...
- I want the option to see the planets I have visited
- I want the option to see the aliens I've interacted with
- I want to explore new planets

Extra Bonus
- The Collector is out collecting as well. He jumps to a random planet every time you jump & collects all aliens on that planet.
- Land on the same planet as him & collect all of his aliens!

---

### Initialize ###
Create a new table with info from API, we'll set parameters (ie Planet only, etc)

########### PROGRAM STARTS ################
 - Welcome Screen -
Title: "Rickless Adventures with Morty"
[bonus: ascii art of Rick & Morty]
Enter your username: _

New User - Goes through story
Previous - "Welcome back, {username}!"

######### WELCOME MENU ##############
1 - Select a Planet
    a - Previously visited Planets
    b - Not yet explored Planets
    c - Search by Planet name
2 - Go to a random Planet
3 - View Morty-dex
4 - Logout
5 - View High Scores

### Previously visited Planets, Not yet explored planets ###
1. Planet 1
2. Planet 2
..
..
6. Next page of planets
7. Go back to the previous menu

### Search by Planet name ###
- Get user input
- Return planet confirmation
  # if planet does not exist, ask to search again
  1. Press 1 to go
  2. Search again
  3. Go back to previous menu

### Go to random/selected Planet ###
- Greeting from planet (knows if you have been there before)
1. Explore planet (amount of points possible)
   # cannot interact with more than 2 aliens
   # after the second, the third attempt will kick us to a random planet
   a. Find local residents/aliens (safe route) (Points of top two aliens possible)
      - Make friends/collect (we add them to our mortydex)
      - kill them (we update their status in our mortydex)
   b. Get a drink/go to bar (gamble, random true/false) (100% or 0% of points possible)
       - true - all residents added to mortydex
       - false - all residents removed from mortydex
               - get blacklisted from planet and removed from your mortydex
2. Find another planet
   - Goes to `Welcome Menu`
3. Archive planet
   - mark planet as complete so it will not show up in our welcome menu
4. Go home (exits game)
