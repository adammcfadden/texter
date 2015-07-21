class AddInboundToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :inbound, :boolean, default: false
  end
end
