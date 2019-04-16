class Mortydex < ActiveRecord::Base

  belongs_to :user
  belongs_to :alien 
# has_many :planets, through: :aliens
# has_many :aliens, through: :users


end
