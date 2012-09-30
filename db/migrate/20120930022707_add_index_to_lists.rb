class AddIndexToLists < ActiveRecord::Migration
  def change
    add_column :lists, :index, :integer
  end
end
