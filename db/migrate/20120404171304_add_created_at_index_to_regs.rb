class AddCreatedAtIndexToRegs < ActiveRecord::Migration
  def change
  	add_index :regs, :created_at
  end
end
