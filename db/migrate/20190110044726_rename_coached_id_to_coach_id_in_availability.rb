class RenameCoachedIdToCoachIdInAvailability < ActiveRecord::Migration[5.2]
  def change
    rename_column :availabilities, :coached_id, :coach_id
  end
end
