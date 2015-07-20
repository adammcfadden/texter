class CreateTos < ActiveRecord::Migration
  def change
    create_table :tos do |t|
      t.string :number
      t.integer :message_id
    end

    remove_column :messages, :to
  end
end
