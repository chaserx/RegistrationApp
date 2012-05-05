class AddRemindedToUser < ActiveRecord::Migration
  def change
    add_column :users, :reminded, :boolean, :default => false

  end
end
