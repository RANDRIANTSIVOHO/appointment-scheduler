class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :coach_id
      t.integer :student_id
      t.integer :slot_id

      t.timestamps
    end
    add_index :appointments, :coach_id
    add_index :appointments, :student_id
    add_index :appointments, :slot_id
  end
end
