class RenameAvailabilitiesIdToAvailabilityIdForSlot < ActiveRecord::Migration[5.2]
  def change
    rename_column :slots, :availabilities_id, :availability_id
  end
end
