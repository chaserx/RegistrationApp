class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :reg_available
      t.datetime :dtstart
      t.datetime :dtend
      t.integer :max_capacity

      t.timestamps
    end
  end
end
