class ChangeToInMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :to
    add_column :messages, :to, :text, array: true, default: [] 
  end
end
