class Planet < ActiveRecord::Base

  has_many :aliens
  # has_many :users, through: :mortydexes
  has_many :mortydexes, through: :aliens

end
