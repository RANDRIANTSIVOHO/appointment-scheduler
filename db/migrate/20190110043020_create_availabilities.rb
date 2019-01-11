class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.integer :coached_id
      t.integer :day_of_week
      t.string :start
      t.string :end

      t.timestamps
    end
    add_index :availabilities, :coached_id
  end
end
