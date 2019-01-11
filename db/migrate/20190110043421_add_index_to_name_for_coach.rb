class AddIndexToNameForCoach < ActiveRecord::Migration[5.2]
  def change
    add_index :coaches, :name
  end
end
