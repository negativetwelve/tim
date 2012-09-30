class AddInputToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :input, :text
  end
end
