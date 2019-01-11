class RenameTableCoachToUser < ActiveRecord::Migration[5.2]
  def up
    rename_table :coaches, :users
  end

  def down
    rename_table :users, :coaches
  end
end
