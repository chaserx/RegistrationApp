class RemoveAnnouncementsTable < ActiveRecord::Migration
  def change
  	drop_table :announcements
  end
end
