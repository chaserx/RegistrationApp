class ChangeColumnsInRegToBooleans < ActiveRecord::Migration
  def change
  	change_column :regs, :eveningsession, :boolean, :default => false
  	change_column :regs, :lunch, :boolean, :default => false
  	change_column :regs, :guest, :boolean, :default => false
  end
end
