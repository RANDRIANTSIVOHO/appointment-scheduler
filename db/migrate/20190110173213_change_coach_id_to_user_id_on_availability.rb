class ChangeCoachIdToUserIdOnAvailability < ActiveRecord::Migration[5.2]
  def up
    rename_column :availabilities, :coach_id, :user_id
  end

  def down
    rename_column :availabilities, :user_id, :coach_id
  end
end
