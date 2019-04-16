class CreateMortydex < ActiveRecord::Migration[5.0]
  def change
    create_table :mortydex do |t|
      t.integer :user_id
      t.integer :alien_id
    end
  end
end
