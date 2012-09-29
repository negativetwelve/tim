class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.datetime :deadline

      t.timestamps
    end
    add_index :lists, [:user_id, :created_at]
  end
end
