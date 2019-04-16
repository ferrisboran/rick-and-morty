### Notes
- 10 planet jumps - we will need a round count
- Sum up score every planet

### Initialize ###
Create a new table with info from API, we'll set parameters (ie Planet only, etc)

### PROGRAM STARTS ###
 - Welcome Screen -
Title: "Rickless Adventures with Morty"
[bonus: ascii art of Rick & Morty]
Enter your username: _

New User - Goes through story
Previous - "Welcome back, {username}!"

### WELCOME MENU ###
1 - Select a Planet
    a - Previously visited Planets
    b - Not yet explored Planets
    c - Search by Planet name
2 - Go to a random Planet
3 - View Morty-dex
4 - View High Scores
5 - Logout

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
  ##### if planet does not exist, ask to search again
  1. Press 1 to go
  2. Search again
  3. Go back to previous menu

### Go to random/selected Planet ###
- Greeting from planet (knows if you have been there before)
1. Explore planet (amount of points possible)
   ##### cannot interact with more than 2 aliens
   ##### after the second, the third attempt will kick us to a random planet
   a. Find local residents/aliens (safe route) (Points of top two aliens possible)
      - Make friends/collect (we add them to our mortydex)
      - kill them (we update their status in our mortydex)
   b. Get a drink/go to bar (gamble, random true/false) (100% or 0% of points possible)
       - true - all residents added to mortydex
       - false
         - all residents removed from mortydex
         - get blacklisted from planet and removed from your mortydex
2. Find another planet
   - Goes to `Welcome Menu`
3. Archive planet
   - mark planet as complete so it will not show up in our welcome menu
4. Go home (exits game)

### View Morty-dex ###
Total Aliens Collected: x out of total
Total Planets Visited: x out of total

1. Alien 1
   - Planet: Planet Name
   - Species: Species Name
   - Status: Alive/Dead (Dead is worth half the points)
   - Point value
2. Alien 2
..
6. Next page
7. Go back to previous menu
   - Welcome Menu

### View High Score ###
Current Score - Total Points

1. User 1 - Total Points
2. User 2 - Total Points
3. User 3 - Total Points
..
6. Previous menu
   - Welcome Menu
