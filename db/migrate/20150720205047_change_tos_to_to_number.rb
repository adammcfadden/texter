class ChangeTosToToNumber < ActiveRecord::Migration
  def change
    rename_table :tos, :to_number
  end
end
