class ChangeTosToToNumbers < ActiveRecord::Migration
  def change
    rename_table :to_number, :to_numbers
  end
end
