class Alien < ActiveRecord::Base
<<<<<<< HEAD

=======
#
#
belongs_to :planet
>>>>>>> master
has_many :users, through: :mortydexes
has_many :mortydexes

end
