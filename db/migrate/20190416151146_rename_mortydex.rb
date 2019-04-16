class RenameMortydex < ActiveRecord::Migration[5.0]
  def change
    rename_table :mortydex, :mortydexes
  end
end
