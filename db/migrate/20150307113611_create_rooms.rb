class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :max

      t.timestamps null: false
    end
  end
end
