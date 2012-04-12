class CreateEmailannouncements < ActiveRecord::Migration
  def change
    create_table :emailannouncements do |t|
      t.text :announcement_body
      t.boolean :sent

      t.timestamps
    end
  end
end
