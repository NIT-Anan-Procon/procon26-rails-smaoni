class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :x
      t.integer :y

      t.timestamps null: false
    end
  end
end
