# fork{ exec 'afplay', File.join(Dir.pwd, "../sound/Rick-and-Morty-Theme-Song.mp3") }
fork{ exec "afplay -t 5 #{File.expand_path('../../sound/Rick-and-Morty-Theme-Song.mp3', __FILE__)}" }

@title_ascii = "\033[1;32m\
 ____  _      _    _                    _       _                 _
|  _ \\(_) ___| | _| | ___  ___ ___     / \\   __| |_   _____ _ __ | |_ _   _ _ __ ___
| |_) | |/ __| |/ / |/ _ \\/ __/ __|   / _ \\ / _` \\ \\ / / _ \\ '_ \\| __| | | | '__/ _ \\
|  _ <| | (__|   <| |  __/\\__ \\__ \\  / ___ \\ (_| |\\ V /  __/ | | | |_| |_| | | |  __/
|_| \\_\\_|\\___|_|\\_\\_|\\___||___/___/ /_/   \\_\\__,_| \\_/ \\___|_| |_|\\__|\\__,_|_|  \\___|

                      _ _   _       __  __            _
            __      _(_) |_| |__   |  \\/  | ___  _ __| |_ _   _
            \\ \\ /\\ / / | __| '_ \\  | |\\/| |/ _ \\| '__| __| | | |
             \\ V  V /| | |_| | | | | |  | | (_) | |  | |_| |_| |
              \\_/\\_/ |_|\\__|_| |_| |_|  |_|\\___/|_|   \\__|\\__, |
                                                          |___/

#{"WubbaLubbaDubDub!".center(78)} "

@user_create_or_login = "\033[1;32m\
        ___
    . -^   `--,
   /# =========`-_
  /# (--====___====\\
 /#   .- --.  . --.|
/##   |  * ) (   * ),
|##   \\    /\\ \\   / |
|###   ---   \\ ---  |
|####      ___)    #|
|######           ##|
 \\##### ---------- /
  \\####           (
   `\\###          |
     \\###         |
      \\##        |
       \\###.    .)
        `======/

  SHOW ME WHAT YOU GOT!

        \033[0m "
