class AddDefaultForAvailableToSlots < ActiveRecord::Migration[5.2]
  def up
    change_column :slots, :available, :boolean, default: true
  end
  def down
    change_column :slots, :available, :boolean, default: nil
  end
end
