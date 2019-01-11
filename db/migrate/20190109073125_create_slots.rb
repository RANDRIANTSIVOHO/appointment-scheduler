class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.integer :availabilities_id
      t.boolean :available, default: true
      t.string :start

      t.timestamps
    end
    add_index :slots, :availabilities_id
  end
end
