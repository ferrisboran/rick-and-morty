class CreateAliens < ActiveRecord::Migration[5.0]
  def change
    create_table :aliens do |t|
      t.string :name
      t.string :status
      t.string :species
      t.integer :planet_id
      t.integer :points
    end
  end
end
